using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using UnityEngine;
using UnityEngine.Pool;
using UnityEngine.UI;

namespace Ase;

[Obsolete]
public class LoadMapGrids : MonoBehaviour
{
	[SerializeField]
	private ScrollRect scroll;

	[SerializeField]
	private RectTransform map;

	[SerializeField]
	private RectTransform gridRoot;

	[SerializeField]
	private GridLayoutGroup gridLayoutGroup;

	[SerializeField]
	private Image gridTpl;

	private string assetPath;

	private string assetTag = "Map";

	private GameObjectPool _gridsPool;

	public MapGridsParam _mapGridsParam;

	private bool _initialized;

	private List<Sprite> allSprites;

	private void Init()
	{
		_gridsPool = new GameObjectPool(gridTpl.gameObject, gridRoot);
		_initialized = true;
		if (_mapGridsParam != null)
		{
			Reload(_mapGridsParam);
		}
	}

	public async Task Reload(MapGridsParam param)
	{
		_mapGridsParam = param;
		_ = _initialized;
	}

	private void ReloadUILayout(MapGridsParam param)
	{
		map.sizeDelta = param.MapSize;
		gridLayoutGroup.cellSize = param.GridSize;
	}

	private async void ReloadGrids(MapGridsParam param)
	{
		int num = (int)Math.Ceiling(param.MapSize.x / param.GridSize.x);
		int num2 = (int)Math.Ceiling(param.MapSize.y / param.GridSize.y);
		gridLayoutGroup.constraint = GridLayoutGroup.Constraint.FixedColumnCount;
		gridLayoutGroup.constraintCount = num;
		_gridsPool.RecycleAll();
		int index = 0;
		for (int i = 0; i < num; i++)
		{
			for (int j = 0; j < num2; j++)
			{
				index++;
				Image component = _gridsPool.Allocate().GetComponent<Image>();
				component.name = $"{index}";
				component.transform.SetSiblingIndex(index);
				Color color = component.color;
				Sprite sprite = allSprites.Find((Sprite p) => p.name.Equals($"{param.GridAssetPrefix}{index}"));
				if (sprite != null)
				{
					component.sprite = sprite;
					component.color = new Color(color.r, color.g, color.b, 1f);
				}
				else
				{
					component.sprite = null;
					component.color = new Color(color.r, color.g, color.b, 0f);
				}
			}
		}
	}

	private void UnloadGridAsset()
	{
		try
		{
			if (allSprites != null)
			{
				CollectionPool<List<Sprite>, Sprite>.Release(allSprites);
			}
			if (!string.IsNullOrEmpty(assetPath))
			{
				GameEntry.Resource.UnloadAsset(AssetUtility.GetTextureAsset(assetPath));
			}
		}
		catch (Exception)
		{
			throw;
		}
	}

	private void Start()
	{
		Init();
	}

	private void OnDestroy()
	{
		_gridsPool?.Dispose();
		_gridsPool = null;
		UnloadGridAsset();
	}
}
