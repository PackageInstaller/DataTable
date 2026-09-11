using ControllerExSpace;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace RogueCard;

public class JokerCommonCard : MonoBehaviour, IPointerClickHandler, IEventSystemHandler, IRogueCardNeedTip
{
	[HideInInspector]
	public int index;

	[HideInInspector]
	public int id;

	[HideInInspector]
	public int versionID;

	[HideInInspector]
	public bool selected;

	[Header("Bind")]
	public ControllerExCollection controllerExCollection;

	private ControllerEx selectController;

	private ControllerEx tipController;

	private ControllerEx qualityController;

	private ControllerEx newController;

	public Image icon;

	public Image versionIcon;

	public Animator ani;

	public Animator rootAni;

	public void Awake()
	{
		selectController = controllerExCollection.GetController("select");
		tipController = controllerExCollection.GetController("looktips");
		qualityController = controllerExCollection.GetController("quality");
		newController = controllerExCollection.GetController("new");
	}

	public void SetData(int id, int index)
	{
		this.index = index;
		this.id = id;
		RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg x) => x.id == id);
		qualityController.SetSelectedIndex(rogueCardItemCfg.rare - 1);
		AtlasManager.GetSpriteWithoutAtlas(icon, "TextureConfig/Activity_JokerCard/item/" + rogueCardItemCfg.icon);
	}

	public void SetNew(bool isNew)
	{
		newController.SetSelectedState(isNew ? "on" : "off");
	}

	public void SetVersion(int versionID)
	{
		this.versionID = versionID;
		if (versionID == 0)
		{
			versionIcon.gameObject.SetActive(value: false);
			return;
		}
		versionIcon.gameObject.SetActive(value: true);
		RogueCardEnhanceCfg rogueCardEnhanceCfg = RogueCardDataManager.enhanceDatabase[versionID];
		AtlasManager.GetSpriteWithoutAtlas(versionIcon, "TextureConfig/Activity_JokerCard/itembg/" + rogueCardEnhanceCfg.icon);
	}

	public void SetSelect(bool isSelect)
	{
		selected = isSelect;
		if (isSelect)
		{
			if (selectController != null)
			{
				selectController.SetSelectedState("on");
			}
			if (!rootAni.GetCurrentAnimatorStateInfo(0).IsName("UI_Com_RogueCardBaseItem_select"))
			{
				rootAni.Play("UI_Com_RogueCardBaseItem_select");
			}
		}
		else
		{
			if (selectController != null)
			{
				selectController.SetSelectedState("off");
			}
			rootAni.Play("empty");
			rootAni.Rebind();
		}
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (!RogueCardGameMain.CheckDisableInput(LockItemType.packageItem, index))
		{
			RogueCardGameMain.Instance.PackageJokerSelect(index, this);
		}
	}

	public void SetLookTips(bool isSelect)
	{
		tipController.SetSelectedState(isSelect ? "on" : "off");
	}
}
