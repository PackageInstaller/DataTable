using ACT.Core;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class NeedNumComponent : MonoBehaviour
{
	public enum NeedNumType
	{
		Item,
		Attribute
	}

	[SerializeField]
	private BImage icon;

	[SerializeField]
	private TextMeshProUGUI numText;

	[SerializeField]
	private Color lackingColor = Color.red;

	[SerializeField]
	private Color normalColor = Color.white;

	private NeedNumType _type;

	private int _id;

	private int _needNum;

	private ImageAssetStation _station;

	public void Init(NeedNumType needNumType, int id, int hasNum, int needNum, bool needChangeColor = true)
	{
		_type = needNumType;
		_id = id;
		_needNum = needNum;
		if (_station == null)
		{
			_station = ImageManager.instance.GetAssetStation();
		}
		gameObject.SetActive(value: true);
		if (_type == NeedNumType.Item && id != 0)
		{
			int iconAddress = CoreUtils.GetData(id, RuntimeConfigs.data.itemDatas).iconAddress;
			_station.LoadItemIcon(iconAddress, icon);
		}
		numText.text = needNum.FastToString();
		if (needChangeColor)
		{
			numText.color = ((hasNum < needNum) ? lackingColor : normalColor);
		}
	}

	private void OnDisable()
	{
		if (_station != null)
		{
			ImageManager.instance.UnloadAssetStation(_station);
			_station = null;
		}
	}

	private void OnDestroy()
	{
		if (_station != null)
		{
			ImageManager.instance.UnloadAssetStation(_station);
			_station = null;
		}
	}

	public void Refresh(int num)
	{
		numText.text = num.FastToString();
	}

	public int GetCurNeedNum()
	{
		return _needNum;
	}
}
