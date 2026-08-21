using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourBaseItem : UGuiView
{
	[SerializeField]
	private GameObject selfObj;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private Image armourIcon;

	[SerializeField]
	private Image rankBg;

	[SerializeField]
	private TextMeshProUGUI rank;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private GameObject levelBg;

	[SerializeField]
	private Image mainEntryIcon;

	[SerializeField]
	private GameObject mainEntryObj;

	private ArmourBaseItemData viewModel;

	public void Init(ArmourBaseItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<ArmourBaseItem, ArmourBaseItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(selfObj).For((GameObject v) => v.activeSelf).ToExpression((ArmourBaseItemData vm) => !vm.IsEmpty);
		bindingSet.Bind(armourIcon).For((Image v) => v.sprite).ToExpression((ArmourBaseItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((ArmourBaseItemData vm) => $"RarityBG_Large_{vm.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(rankBg).For((Image v) => v.color).To((ArmourBaseItemData vm) => vm.RankColor);
		bindingSet.Bind<TextMeshProUGUI>(rank).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ArmourBaseItemData vm) => $"R{vm.Rank}");
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourBaseItemData vm) => vm.Level);
		bindingSet.Bind(levelBg).For((GameObject v) => v.activeSelf).ToExpression((ArmourBaseItemData vm) => !vm.IsRock);
		bindingSet.Build();
		LoadMainEntry();
	}

	private async void LoadMainEntry()
	{
		if (mainEntryIcon != null && viewModel.IsRock)
		{
			string textureIconSprite = AssetUtility.GetTextureIconSprite("BuffIcon/Folder/EntryIcon/" + viewModel.MainEntryIcon + "_Rock.png");
			Image image = mainEntryIcon;
			image.sprite = await LoadSpriteAsync(textureIconSprite);
			mainEntryObj.SetActive(value: true);
		}
		else
		{
			mainEntryObj.SetActive(value: false);
		}
	}

	public void RefreshDataArmourBase(ArmourBaseItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
