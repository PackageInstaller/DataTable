using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI;
using Bamboo.ImageCenter;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;

public class RogueBagInscriptionItem : MonoBehaviour, ISubmitHandler, IEventSystemHandler
{
	public BImage imageInscriptionItemIcon;

	public LocalizeStringEvent imageInscriptionName;

	public TextMeshProUGUI InscriptionLevel;

	public InscriptionItemLevel InscriptionItemLevel;

	public ActButton ClickButton;

	public int Id;

	public GameObject GoSelect;

	private void Start()
	{
	}

	public void Init(int id, ImageAssetStation station)
	{
		Id = id;
		Inscription data = CoreUtils.GetData(id, RuntimeConfigs.data.inscriptions);
		if (data != null)
		{
			imageInscriptionName.StringReference.TableEntryReference = data.name;
			InscriptionItemLevel.Init(data.synergyIds, Model<RogueNewModel>.Interface.GetInscriptionById(Id));
			InscriptionLevel.SetText("{0:0}", Model<RogueNewModel>.Interface.GetInscriptionById(id));
			station.LoadImage(189, data.iconAddress, imageInscriptionItemIcon);
		}
	}

	private void Update()
	{
	}

	public void OnSubmit(BaseEventData eventData)
	{
		ClickButton.OnClick?.Invoke();
	}
}
