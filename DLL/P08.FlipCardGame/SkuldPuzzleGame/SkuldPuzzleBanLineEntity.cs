using Unity.Mathematics;
using UnityEngine;

namespace SkuldPuzzleGame;

public class SkuldPuzzleBanLineEntity : MonoBehaviour
{
	public SkuldPuzzleBanLineData banLineData;

	private int mapWidth;

	private int mapHeight;

	public void InitBanLineData(SkuldPuzzleBanLineData banLineData, int width, int height)
	{
		this.banLineData = banLineData;
		mapWidth = width;
		mapHeight = height;
		RefreshLayout();
	}

	public Vector2 CalculateTilePosByIndex(int tileIndex)
	{
		if (mapWidth == 0)
		{
			return Vector2.zero;
		}
		int num = SkuldPuzzleConst.cubeSize + SkuldPuzzleConst.cubeSpace / 2;
		int num2 = tileIndex % mapWidth;
		return new Vector2(y: tileIndex / mapWidth * num - mapHeight * num / 2 + num / 2, x: num2 * num - mapWidth * num / 2 + num / 2);
	}

	private void RefreshLayout()
	{
		RefreshLayoutPos();
		RefreshLayoutAngle();
	}

	public void RefreshLayoutPos()
	{
		int tileIndexA = banLineData.tileIndexA;
		int tileIndexB = banLineData.tileIndexB;
		Vector2 vector = CalculateTilePosByIndex(tileIndexA);
		Vector2 vector2 = CalculateTilePosByIndex(tileIndexB);
		base.transform.localPosition = new Vector2((vector.x + vector2.x) / 2f + 17f, (vector.y + vector2.y) / 2f - 2f);
	}

	public void RefreshLayoutAngle()
	{
		int tileIndexA = banLineData.tileIndexA;
		int tileIndexB = banLineData.tileIndexB;
		if (math.abs(tileIndexA - tileIndexB) == 1)
		{
			base.transform.eulerAngles = Vector3.zero;
		}
		else
		{
			base.transform.eulerAngles = Vector3.forward * 90f;
		}
	}

	public void Dispose()
	{
		if ((bool)base.gameObject)
		{
			Object.DestroyImmediate(base.gameObject);
		}
	}
}
