using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoCharacterGetView : BaseUIView
{
	private MonoCharacterGetViewData m_Data;

	[SerializeReference]
	private BImage bigNameBImage;

	[SerializeReference]
	private BImage smallNameBImage;

	[SerializeReference]
	private BImage typeBImage;

	[SerializeReference]
	private BImage difficultyBImage;

	[SerializeReference]
	private BImage characterPortraitBImage;

	public LocalizeStringEvent typeLocalize;

	public Image bgImage;

	public Canvas characterCanvas;

	private bool typeLocalizeUpdateDone;

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_Data = uiViewData as MonoCharacterGetViewData;
		characterCanvas.sortingLayerName = NewUIManager.SortingLayers[SortingLayer].name;
		await UpdateCharacterInfo();
	}

	protected override void Init()
	{
		base.Init();
	}

	protected override void UnInit()
	{
		base.UnInit();
		typeLocalize.StringReference.TableEntryReference = 0L;
	}

	protected override void PlayOpenAnimation()
	{
		uiEffectAnimator.Play("Show");
	}

	protected override void PlayCloseAnimation()
	{
		uiEffectAnimator.Play("Hide");
	}

	private async UniTask UpdateCharacterInfo()
	{
		EntityCharacterData entityCharacterData = RuntimeConfigs.data.entityCharacterDatas[m_Data.characterId];
		typeLocalizeUpdateDone = false;
		UniTask uniTask = Station.LoadImageAsync(113, entityCharacterData.characterNameEng, bigNameBImage);
		UniTask uniTask2 = Station.LoadImageAsync(113, entityCharacterData.characterNameCh, smallNameBImage);
		UniTask uniTask3 = Station.LoadImageAsync(113, entityCharacterData.characterIcon, typeBImage);
		UniTask uniTask4 = Station.LoadImageAsync(113, entityCharacterData.difficulty, difficultyBImage);
		UniTask uniTask5 = Station.LoadImageAsync(113, entityCharacterData.characterArt, characterPortraitBImage);
		typeLocalize.StringReference.TableEntryReference = entityCharacterData.characterType;
		bgImage.color = new Color((float)entityCharacterData.effectsRGB[0] / 255f, (float)entityCharacterData.effectsRGB[1] / 255f, (float)entityCharacterData.effectsRGB[2] / 255f, (float)entityCharacterData.effectsRGB[3] / 255f);
		await UniTask.WhenAll(uniTask, uniTask2, uniTask3, uniTask4, uniTask5, UniTask.WaitUntil(() => typeLocalizeUpdateDone));
	}

	public void TypeLocalizeUpdateDone()
	{
		typeLocalizeUpdateDone = true;
	}
}
