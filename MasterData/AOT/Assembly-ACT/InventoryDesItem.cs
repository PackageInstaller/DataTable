using ACT.Config;
using ACT.Core;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

public class InventoryDesItem : MonoBehaviour
{
	public LocalizeStringEvent TextType;

	public LocalizeStringEvent TextName;

	public GameObject GoUp;

	private TextMeshProUGUI _textName;

	private int _itemCount;

	private bool _isInitialized;

	private void Awake()
	{
		_textName = TextName.GetComponent<TextMeshProUGUI>();
		TextName.OnUpdateString.AddListener(OnNameLocalized);
	}

	private void OnDestroy()
	{
		TextName.OnUpdateString.RemoveListener(OnNameLocalized);
	}

	private void OnNameLocalized(string itemName)
	{
		if (_isInitialized)
		{
			_textName.text = ((_itemCount == 1) ? itemName : $"{itemName}×{_itemCount}");
		}
	}

	public void Init(ItemKv item, int itemQuantity)
	{
		ItemData data = CoreUtils.GetData(item.id, RuntimeConfigs.data.itemDatas);
		if (data != null)
		{
			_itemCount = itemQuantity;
			_isInitialized = true;
			TextName.StringReference.TableEntryReference = data.nameLocal;
			TextType.StringReference.TableEntryReference = data.typeLocal;
			GoUp.SetActive(item.count == 1);
		}
	}
}
