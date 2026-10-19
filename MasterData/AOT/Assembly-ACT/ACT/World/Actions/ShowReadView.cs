using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Unity.VisualScripting;
using UnityEngine;

namespace ACT.World.Actions;

public class ShowReadView : InteractAction
{
	public enum ReadType
	{
		Vertical,
		Horizontal
	}

	public ReadType type;

	[Header("Vertical")]
	public int tieleId;

	[Serialize]
	public List<VerticalInfo> verticalInfos;

	[Header("Horizontal")]
	public List<HorizontalInfo> horizontalInfos;

	protected override AbilityAuth auth => AbilityAuth.ClientOwner;

	protected override async UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		switch (type)
		{
		case ReadType.Vertical:
		{
			MonoVerticalReadView.VerticalInfos uiData = new MonoVerticalReadView.VerticalInfos
			{
				titleId = tieleId,
				infos = verticalInfos
			};
			await Fundamental.Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_VERTICALREAD, uiData);
			break;
		}
		case ReadType.Horizontal:
			await Fundamental.Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_HORIZONTALREAD, horizontalInfos);
			break;
		}
	}
}
