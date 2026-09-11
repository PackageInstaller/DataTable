using System;
using System.Collections.Generic;
using UnityEngine;

namespace Dorm;

public class TileCoordinate<T> where T : TileEntity, new()
{
	public Vector3 originalPoint;

	public Vector2 originalCoordinatePoint;

	public int width;

	public int height;

	public T[] enitieS;

	public TileType tileType;

	public const float OFFECT_DECIMAL = 0.01f;

	public float TileSize { get; private set; }

	public TileCoordinate(float tileSize)
	{
		TileSize = tileSize;
	}

	public void Init(Vector3 originalPoint, int width, int height, TileType tileType)
	{
		this.originalPoint = originalPoint;
		this.tileType = tileType;
		this.width = width;
		this.height = height;
		originalCoordinatePoint = Position2Coordinate(this.originalPoint);
		enitieS = new T[this.width * this.height];
		GenerateCoordinate();
	}

	private void GenerateCoordinate()
	{
		_ = TileSize;
		for (short num = 0; num < height; num++)
		{
			for (short num2 = 0; num2 < width; num2++)
			{
				int num3 = CoordToIndex(num2, num);
				enitieS[num3] = new T();
				enitieS[num3].coordinateX = num2;
				enitieS[num3].coordinateY = num;
			}
		}
	}

	public void ClearCoordinateOccypy()
	{
		if (enitieS != null)
		{
			for (int i = 0; i < enitieS.Length; i++)
			{
				enitieS[i].isOccupy = false;
			}
		}
	}

	public int CoordToIndex(int x, int z)
	{
		return x + z * width;
	}

	public Vector2Int IndexToCoord(int index)
	{
		return new Vector2Int(index - index / width * width, index / width);
	}

	public T FindEntity(int index)
	{
		if (enitieS != null && enitieS.Length > index && index >= 0)
		{
			return enitieS[index];
		}
		return null;
	}

	public T FindEntity(int x, int z)
	{
		int index = CoordToIndex(x, z);
		return FindEntity(index);
	}

	public List<Int2> GetGroupS(int x, int z, int radius)
	{
		List<Int2> list = new List<Int2>();
		for (int i = x * radius; i < (x + 1) * radius; i++)
		{
			for (int j = z * radius; j < (z + 1) * radius; j++)
			{
				if (i < width && j < height)
				{
					list.Add(new Int2(i, j));
				}
			}
		}
		return list;
	}

	public List<Vector2Int> FillRectOccupy(Vector3 position, int width, int height, float rotation)
	{
		bool isHaveOutSide = false;
		List<Vector2Int> hitEntityIndexS = GetHitEntityIndexS(position, width, height, rotation, out isHaveOutSide);
		for (int i = 0; i < hitEntityIndexS.Count; i++)
		{
			T val = FindEntity(hitEntityIndexS[i].x, hitEntityIndexS[i].y);
			if (val != null)
			{
				val.isOccupy = true;
			}
		}
		return hitEntityIndexS;
	}

	public List<Vector2Int> RemoveRectOccupy(Vector3 position, int width, int height, float rotation)
	{
		bool isHaveOutSide = false;
		List<Vector2Int> hitEntityIndexS = GetHitEntityIndexS(position, width, height, rotation, out isHaveOutSide);
		for (int i = 0; i < hitEntityIndexS.Count; i++)
		{
			T val = FindEntity(hitEntityIndexS[i].x, hitEntityIndexS[i].y);
			if (val != null)
			{
				val.isOccupy = false;
			}
		}
		return hitEntityIndexS;
	}

	public bool GetIsAvailable(Vector3 position, int width, int height, float rotation)
	{
		bool isHaveOutSide = false;
		List<Vector2Int> hitEntityIndexS = GetHitEntityIndexS(position, width, height, rotation, out isHaveOutSide);
		if (isHaveOutSide)
		{
			return false;
		}
		for (int i = 0; i < hitEntityIndexS.Count; i++)
		{
			T val = FindEntity(hitEntityIndexS[i].x, hitEntityIndexS[i].y);
			if (val != null && val.isOccupy)
			{
				return false;
			}
		}
		return true;
	}

	public List<Vector2Int> GetHitEntityIndexS(Vector3 position, int width, int height, float rotation, out bool isHaveOutSide)
	{
		float tileSize = TileSize;
		Vector2 mid = Position2Coordinate(position);
		Vector2 point = new Vector2(mid.x - (float)width * tileSize / 2f + 0.01f, mid.y + (float)height * tileSize / 2f - 0.01f);
		Vector2 rotatePoint = GetRotatePoint(point, mid, -1f * rotation);
		Vector2 point2 = new Vector2(mid.x + (float)width * tileSize / 2f - 0.01f, mid.y + (float)height * tileSize / 2f - 0.01f);
		Vector2 rotatePoint2 = GetRotatePoint(point2, mid, -1f * rotation);
		Vector2 point3 = new Vector2(mid.x - (float)width * tileSize / 2f + 0.01f, mid.y - (float)height * tileSize / 2f + 0.01f);
		Vector2 rotatePoint3 = GetRotatePoint(point3, mid, -1f * rotation);
		Vector2 point4 = new Vector2(mid.x + (float)width * tileSize / 2f - 0.01f, mid.y - (float)height * tileSize / 2f + 0.01f);
		Vector2 rotatePoint4 = GetRotatePoint(point4, mid, -1f * rotation);
		List<Vector2> list = new List<Vector2>();
		for (int i = 0; i <= height; i++)
		{
			Vector2 a = Vector2.Lerp(rotatePoint, rotatePoint3, (float)i / (float)height);
			Vector2 b = Vector2.Lerp(rotatePoint2, rotatePoint4, (float)i / (float)height);
			for (int j = 0; j <= width; j++)
			{
				list.Add(Vector2.Lerp(a, b, (float)j / (float)width));
			}
		}
		List<Vector2Int> list2 = new List<Vector2Int>();
		isHaveOutSide = false;
		for (int k = 0; k < list.Count; k++)
		{
			Vector2 vector = list[k] - originalCoordinatePoint;
			int num = (int)Math.Ceiling(vector.x / tileSize) - 1;
			int num2 = (int)Math.Ceiling(vector.y / tileSize) - 1;
			if (num >= this.width || num < 0 || num2 >= this.height || num2 < 0)
			{
				isHaveOutSide = true;
				continue;
			}
			int x = Mathf.Clamp(num, 0, this.width);
			int y = Mathf.Clamp(num2, 0, this.height);
			list2.Add(new Vector2Int(x, y));
		}
		return list2;
	}

	public Vector3 FindNearestPosition(Vector3 position, bool isLimit, bool wallMountLayOnGround, int width, int height, bool snapByCeilToInt)
	{
		float tileSize = TileSize;
		Vector3 vector = position - originalPoint;
		Vector2 vector2 = new Vector2(0.5f * (float)width, 0.5f * (float)height);
		switch (tileType)
		{
		case TileType.WALL_LEFT:
		case TileType.WALL_RIGHT:
		{
			Vector2 v2 = new Vector2(vector.z / tileSize, vector.y / tileSize) - vector2;
			if (isLimit)
			{
				v2.x = Mathf.Clamp(v2.x, 0f, this.width - width);
				v2.y = Mathf.Clamp(v2.y, 0f, this.height - height);
			}
			if (wallMountLayOnGround)
			{
				v2.y = 0f;
			}
			Vector2 vector4 = vector2 + (snapByCeilToInt ? Vector2Int.CeilToInt(v2) : Vector2Int.FloorToInt(v2));
			return originalPoint + tileSize * new Vector3(0f, vector4.y, vector4.x);
		}
		case TileType.WALL_FRONT:
		case TileType.WALL_BEHIND:
		{
			Vector2 v3 = new Vector2(vector.x / tileSize, vector.y / tileSize) - vector2;
			if (isLimit)
			{
				v3.x = Mathf.Clamp(v3.x, 0f, this.width - width);
				v3.y = Mathf.Clamp(v3.y, 0f, this.height - height);
			}
			if (wallMountLayOnGround)
			{
				v3.y = 0f;
			}
			Vector2 vector5 = vector2 + (snapByCeilToInt ? Vector2Int.CeilToInt(v3) : Vector2Int.FloorToInt(v3));
			return originalPoint + tileSize * new Vector3(vector5.x, vector5.y, 0f);
		}
		default:
		{
			Vector2 v = new Vector2(vector.x / tileSize, vector.z / tileSize) - vector2;
			if (isLimit)
			{
				v.x = Mathf.Clamp(v.x, 0f, this.width - width);
				v.y = Mathf.Clamp(v.y, 0f, this.height - height);
			}
			Vector2 vector3 = vector2 + (snapByCeilToInt ? Vector2Int.CeilToInt(v) : Vector2Int.FloorToInt(v));
			return originalPoint + tileSize * new Vector3(vector3.x, 0f, vector3.y);
		}
		}
	}

	public Vector2 Position2Coordinate(Vector3 position)
	{
		switch (tileType)
		{
		case TileType.FLOOR:
		case TileType.CEIL:
			return new Vector2(position.x, position.z);
		case TileType.WALL_FRONT:
		case TileType.WALL_BEHIND:
			return new Vector2(position.x, position.y);
		case TileType.WALL_LEFT:
		case TileType.WALL_RIGHT:
			return new Vector2(position.z, position.y);
		default:
			return new Vector2(0f, 0f);
		}
	}

	public Vector3 Coordinate2Position(Vector2 position)
	{
		switch (tileType)
		{
		case TileType.FLOOR:
		case TileType.CEIL:
			return new Vector3(position.x, originalPoint.y, position.y);
		case TileType.WALL_FRONT:
		case TileType.WALL_BEHIND:
			return new Vector3(position.x, position.y, originalPoint.z);
		case TileType.WALL_LEFT:
		case TileType.WALL_RIGHT:
			return new Vector3(originalPoint.x, position.y, position.x);
		default:
			return new Vector2(0f, 0f);
		}
	}

	public Vector2 GetRotatePoint(Vector2 point, Vector2 mid, float rotation)
	{
		return new Vector2(Mathf.Cos(rotation * (MathF.PI / 180f)) * (point.x - mid.x) - Mathf.Sin(rotation * (MathF.PI / 180f)) * (point.y - mid.y) + mid.x, Mathf.Sin(rotation * (MathF.PI / 180f)) * (point.x - mid.x) + Mathf.Cos(rotation * (MathF.PI / 180f)) * (point.y - mid.y) + mid.y);
	}

	public Vector3 GetRotationAxis()
	{
		switch (tileType)
		{
		case TileType.FLOOR:
		case TileType.CEIL:
			return Vector3.up;
		case TileType.WALL_FRONT:
		case TileType.WALL_BEHIND:
			return Vector3.forward;
		case TileType.WALL_LEFT:
		case TileType.WALL_RIGHT:
			return Vector3.right;
		default:
			return Vector3.zero;
		}
	}

	public float GetRotationAngle(Vector3 localRotEulerAngle)
	{
		return Vector3.Dot(localRotEulerAngle, GetRotationAxis());
	}

	public Vector3 GetRealRotation(float rotation)
	{
		switch (tileType)
		{
		case TileType.FLOOR:
		case TileType.CEIL:
			return new Vector3(0f, rotation, 0f);
		case TileType.WALL_FRONT:
		case TileType.WALL_BEHIND:
			return new Vector3(0f, 0f, rotation);
		case TileType.WALL_LEFT:
		case TileType.WALL_RIGHT:
			return new Vector3(rotation, 0f, 0f);
		default:
			return new Vector2(0f, 0f);
		}
	}
}
