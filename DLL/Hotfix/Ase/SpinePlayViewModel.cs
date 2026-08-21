using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class SpinePlayViewModel : OptionBase
{
	private int _currSkinId;

	private List<int> _spineList = new List<int>();

	private Vector2 _spinePosition;

	private float _spineScale = 1f;

	public int CurrSkinId => _currSkinId;

	public List<int> SpineList => _spineList;

	public Vector2 SpinePosition => _spinePosition;

	public float SpineScale => _spineScale;

	public SpinePlayViewModel()
	{
	}

	public SpinePlayViewModel(OptionBase parent, int enterSkinId)
	{
		base.parent = parent;
		_spineList = GetAllValidSkins();
		if (_spineList != null && _spineList.Count > 0)
		{
			if (!_spineList.Contains(enterSkinId))
			{
				enterSkinId = _spineList[0];
			}
			_currSkinId = enterSkinId;
			SetTransformDefault();
		}
	}

	public void SetCurSkinId(int skinId)
	{
		if (_currSkinId != skinId)
		{
			_currSkinId = skinId;
			SetTransformDefault();
		}
	}

	private string GetLocalCacheKey()
	{
		return "SpinePlay_Transform";
	}

	private string GetLocalCacheString()
	{
		return $"{_currSkinId},{_spinePosition.x},{_spinePosition.y},{_spineScale}";
	}

	private bool AnalyzeLocalTransform(string str, out int lastSkinId, out Vector2 position, out float scale)
	{
		lastSkinId = -1;
		position = Vector2.zero;
		scale = 1f;
		if (string.IsNullOrEmpty(str))
		{
			return false;
		}
		string[] array = str.Split(',');
		if (array.Length < 4)
		{
			return false;
		}
		if (!int.TryParse(array[0], out lastSkinId))
		{
			return false;
		}
		List<float> list = new List<float>();
		for (int i = 1; i < 4; i++)
		{
			if (float.TryParse(array[i], out var result))
			{
				list.Add(result);
				continue;
			}
			return false;
		}
		position = new Vector2(list[0], list[1]);
		scale = list[2];
		return true;
	}

	public void SetTransform(Vector2 position, float scale, bool localSave = true)
	{
		_spinePosition = position;
		_spineScale = scale;
		if (localSave)
		{
			PlayerPrefs.SetString(GetLocalCacheKey(), GetLocalCacheString());
		}
	}

	public void SetTransformDefault(bool localSave = false)
	{
		DRSkinTheater dataRow = GameEntry.DataTable.GetDataRow((DRSkinTheater p) => p.SkinId == _currSkinId);
		if (dataRow != null)
		{
			_spinePosition = new Vector2((dataRow.CameraInit.Count > 0) ? dataRow.CameraInit[0] : 0, (dataRow.CameraInit.Count > 1) ? dataRow.CameraInit[1] : 0);
			_spineScale = ((dataRow.CameraInit.Count <= 2) ? 1 : dataRow.CameraInit[2]);
		}
		else
		{
			_spinePosition = Vector2.zero;
			_spineScale = 1f;
		}
		if (localSave)
		{
			PlayerPrefs.SetString(GetLocalCacheKey(), GetLocalCacheString());
		}
	}

	public static List<int> GetAllValidSkins()
	{
		List<int> list = new List<int>();
		IHeroService service = Singleton<ServiceSystem>.Instance.GetService<IHeroService>();
		if (service == null)
		{
			return list;
		}
		List<int> allHeroSkins = service.GetAllHeroSkins();
		if (allHeroSkins != null)
		{
			foreach (int skinId in allHeroSkins)
			{
				DRSkinTheater dataRow = GameEntry.DataTable.GetDataRow((DRSkinTheater p) => p.SkinId == skinId);
				if (dataRow != null && dataRow.SexRoom)
				{
					list.Add(skinId);
				}
			}
		}
		return list;
	}
}
