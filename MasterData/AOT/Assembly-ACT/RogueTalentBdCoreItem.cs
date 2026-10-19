using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using Runtime.Model;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.SmartFormat.PersistentVariables;

public class RogueTalentBdCoreItem : MonoBehaviour
{
	public BImage ImageBdCoreIcon;

	public LocalizeStringEvent TextName;

	public LocalizeStringEvent TexcDes;

	public GameObject LockRoot;

	public LocalizeStringEvent TextLockDes;

	public GameObject UnLockRoot;

	public BetterAnimation betterAnimation;

	private BdCore _bdCoreData;

	private bool isUnlook;

	private BdUnlockCondition bdUnlockData;

	private bool needPlayUnlockAnimation;

	private void Start()
	{
	}

	public void Init(BdCore data, ImageAssetStation station)
	{
		needPlayUnlockAnimation = false;
		_bdCoreData = data;
		station.LoadImage(196, data.iconAddress, ImageBdCoreIcon);
		TextName.StringReference.TableEntryReference = data.name;
		TexcDes.StringReference.TableEntryReference = data.description;
		bdUnlockData = CoreUtils.GetData(data.bdUnlockConditionId, RuntimeConfigs.data.bdUnlockConditions);
		isUnlook = bdUnlockData == null || Model<RogueNewModel>.Interface.GetAllTalentNodeCost() >= bdUnlockData.number;
		UnLockRoot.SetActive(isUnlook);
		LockRoot.SetActive(!isUnlook);
		if (!isUnlook)
		{
			TextLockDes.StringReference.TableEntryReference = 2535L;
			Variable<string> variable = TextLockDes.StringReference.GetVariable<string>("0");
			int number = bdUnlockData.number;
			variable.Value = number.ToString();
		}
	}

	public void RefreshItem()
	{
		bool flag = bdUnlockData == null || Model<RogueNewModel>.Interface.GetAllTalentNodeCost() >= bdUnlockData.number;
		if (isUnlook != flag)
		{
			needPlayUnlockAnimation = true;
			isUnlook = flag;
			UnLockRoot.SetActive(isUnlook);
			LockRoot.SetActive(!isUnlook);
		}
	}

	public void PlayUnlockAnimation()
	{
		if (needPlayUnlockAnimation)
		{
			betterAnimation.GetSequence("Unlock").Play();
		}
	}

	private void Update()
	{
	}
}
