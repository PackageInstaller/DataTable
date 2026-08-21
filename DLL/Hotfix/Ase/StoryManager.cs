#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using FMOD.Studio;
using GameFramework;
using Spine.Unity;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using Yarn.Unity;

namespace Ase;

public class StoryManager : DialogueViewBase
{
	[SerializeField]
	private RectTransform window;

	[SerializeField]
	private DialogueRunner runner;

	[SerializeField]
	private LineView lineView;

	[SerializeField]
	private Toggle autoToggle;

	[SerializeField]
	private Toggle fastToggle;

	[SerializeField]
	private Animator sceneDetailRoot;

	[SerializeField]
	private TextMeshProUGUI sceneNameText;

	[SerializeField]
	private TextMeshProUGUI sceneTimeText;

	[SerializeField]
	private float fastSpeed;

	public StoryAssets assets;

	[Header("Spine UI settings")]
	[Tooltip("all Spines will be tinted with this color")]
	public Color defaultTint;

	[Tooltip("when speaking, a Spine will be highlighted by tinting it with this color")]
	public Color highlightTint;

	[Header("Object references")]
	[Tooltip("don't change these unless you know what you're doing")]
	public RectTransform spriteGroup;

	[SerializeField]
	private StoryBGController bgController;

	public Image fadeBG;

	public Image nameplateBG;

	public Image FilmBG;

	public List<RectTransform> layers;

	[HideInInspector]
	public Dictionary<string, StoryActor> actors;

	[HideInInspector]
	public Dictionary<string, StoryEffect> effects;

	private bool storyPlayFlag;

	private bool storyEndFlag;

	private StoryEndType storyEndType;

	public DialogueOption[] curDialogueOptions;

	public List<StoryDialogue> happenedDialogues;

	[HideInInspector]
	public Dictionary<string, Sprite> headIcons;

	[HideInInspector]
	public Dictionary<string, Animator> animators;

	private List<AudioParameter> paramList;

	public Dictionary<int, EventInstance> eventInstances;

	private EventInstance sfxEventInstance;

	public bool StoryEndFlag => storyEndFlag;

	private Vector2 WindowSize => window.rect.size;

	private void Awake()
	{
		bgController.Init();
		runner.onSelectAction = OnSelectAction;
		runner.AddCommandHandler("Reset", (Action)ResetScene);
		runner.AddCommandHandler("Start", (Func<IEnumerator>)OnStoryStart);
		runner.AddCommandHandler("End", (Func<IEnumerator>)OnStoryEnd);
		runner.AddCommandHandler("JumpTo", (Func<int, IEnumerator>)JumpTo);
		runner.AddCommandHandler("Scene", (Action<string>)DoSceneChange);
		runner.AddCommandHandler("SceneAsync", (Func<string, float, IEnumerator>)DoSceneChangeAsync);
		runner.AddCommandHandler("FadeCurrentScene", (Action<float, float, float>)FadeCurrentScene);
		runner.AddCommandHandler("FadeCurrentSceneAsync", (Func<float, float, float, IEnumerator>)FadeCurrentSceneAsync);
		runner.AddCommandHandler("MoveScene", (Action<string, string, float>)MoveScene);
		runner.AddCommandHandler("MoveSceneAsync", (Func<string, string, float, IEnumerator>)MoveSceneAsync);
		runner.AddCommandHandler("ShakeScene", (Action<float>)ShakeScene);
		runner.AddCommandHandler("SceneScale", (Action<float, float>)SceneScale);
		runner.AddCommandHandler("SceneScaleAsync", (Func<float, float, IEnumerator>)SceneScaleAsync);
		runner.AddCommandHandler("SceneTime", (Action<string, string>)SetSceneTime);
		runner.AddCommandHandler("BlurScene", (Action<float, float>)BlurScene);
		runner.AddCommandHandler("Actor", (Action<string, string, string, string, string, int, string, string, string>)SetActor);
		runner.AddCommandHandler("ActorSpine", (Action<string, string, string, string>)SetActorSpine);
		runner.AddCommandHandler("ActorAnimate", (Action<string, string>)SetActorState);
		runner.AddCommandHandler("ActorSkin", (Action<string, string>)SetActorSkin);
		runner.AddCommandHandler("ShowActor", (Action<string, float>)ShowActor);
		runner.AddCommandHandler("ShowActorAsync", (Func<string, float, IEnumerator>)ShowActorAsync);
		runner.AddCommandHandler("HideActor", (Action<string, float>)HideActor);
		runner.AddCommandHandler("HideActorAsync", (Func<string, float, IEnumerator>)HideActorAsync);
		runner.AddCommandHandler("HideAllActor", (Action)HideAllActor);
		runner.AddCommandHandler("MoveActor", (Action<string, string, string, float>)MoveActor);
		runner.AddCommandHandler("MoveActorAsync", (Func<string, string, string, float, IEnumerator>)MoveActorAsync);
		runner.AddCommandHandler("FlipActor", (Action<string, string>)FlipActor);
		runner.AddCommandHandler("ShakeActor", (Action<string, float>)ShakeActor);
		runner.AddCommandHandler("MoveActorLayer", (Action<string, int>)SetActorLayer);
		runner.AddCommandHandler("ActorScale", (Action<string, float, float>)SetActorScale);
		runner.AddCommandHandler("ActorScaleAsync", (Func<string, float, float, IEnumerator>)SetActorScaleAsync);
		runner.AddCommandHandler("ActorStateAll", (Action<string, int>)SwitchActorAllState);
		runner.AddCommandHandler("ActorState", (Action<string, string, int>)SwitchActorState);
		runner.AddCommandHandler("Effect", (Action<string, string, int, string, string>)SetEffect);
		runner.AddCommandHandler("ShowEffect", (Action<string>)ShowEffect);
		runner.AddCommandHandler("HideEffect", (Action<string>)HideEffect);
		runner.AddCommandHandler("HideAllEffect", (Action)HideAllEffect);
		runner.AddCommandHandler("MoveEffect", (Action<string, string, string, float>)MoveEffect);
		runner.AddCommandHandler("MoveEffectAsync", (Func<string, string, string, float, IEnumerator>)MoveEffectAsync);
		runner.AddCommandHandler("FlipEffect", (Action<string, string>)FlipEffect);
		runner.AddCommandHandler("Fade", (Action<string, float, float, float>)SetFade);
		runner.AddCommandHandler("FadeIn", (Action<float>)SetFadeIn);
		runner.AddCommandHandler("CamOffset", (Action<string, string, float>)SetCameraOffset);
		runner.AddCommandHandler("WaitTime", (Func<float, IEnumerator>)WaitTime);
		runner.AddCommandHandler("TypeSpeedRatio", (Action<float>)SetTypeSpeedRatio);
		runner.AddCommandHandler("AutoHoldTime", (Action<float>)SetAutoHoldTime);
		runner.AddCommandHandler("BGM", (Action<int, float, float, float, string, float, float>)PlayBGM);
		runner.AddCommandHandler("StopBGM", (Action<int, float, float>)StopBGM);
		runner.AddCommandHandler("PlaySFX", (Action<int, float, string, float, float>)PlaySFX);
		runner.AddCommandHandler("StopSFX", (Action<int>)StopSFX);
		runner.AddCommandHandler("FilmScene", (Action<int>)SetFilmScene);
		runner.AddFunction("GetCharacter", GetCharacter);
		runner.AddCommandHandler("MovieStyle", (Action<string, string>)SetMovieStyle);
		runner.AddCommandHandler("SceneRotation", (Action<string, float, float, float, float>)SetSceneRotation);
		runner.AddCommandHandler("ActorRotation", (Action<string, float, float, float, float>)SetActorRotation);
		runner.AddCommandHandler("Animation", (Action<string, string, int>)PlayAnimation);
		runner.AddCommandHandler("ActiveAnimation", (Action<string, int>)SetAnimatorActive);
		runner.AddCommandHandler("SetAnimation", (Action<string, string, int, int>)SetAnimator);
		runner.AddCommandHandler("SetCRT", (Action<string, string, float>)SetCRTColor);
	}

	public void Play(string startNode, StoryAssets storyAssets, string language)
	{
		(runner.lineProvider as StoryLineProvider).textLanguageCode = language;
		assets = storyAssets;
		storyPlayFlag = false;
		storyEndFlag = false;
		storyEndType = StoryEndType.None;
		RestState();
		BlurScene(0f, 0f);
		SetFilmScene(0);
		runner.StartDialogue(startNode);
	}

	public async UniTask WaitOnStoryPlay()
	{
		await UniTask.WaitUntil(() => storyPlayFlag);
	}

	public async UniTask<StoryEndType> WaitOnStoryEnd()
	{
		await UniTask.WaitUntil(() => storyEndFlag);
		return storyEndType;
	}

	public void Stop(StoryEndType storyEnd = StoryEndType.End)
	{
		storyEndType = storyEnd;
		ClearStoryBGM();
		ResetScene();
		RestState();
		assets = null;
		runner.Stop();
		StopAllCoroutines();
		eventInstances.Clear();
		StopSFX();
	}

	public void StoryStart()
	{
		storyPlayFlag = true;
	}

	public void StoryEnd()
	{
		storyEndFlag = true;
	}

	public IEnumerator OnStoryStart()
	{
		storyPlayFlag = true;
		yield return WaitTime(1f);
	}

	public IEnumerator OnStoryEnd()
	{
		storyEndFlag = true;
		yield return WaitTime(1f);
	}

	public IEnumerator JumpTo(int dataId)
	{
		yield return OnStoryEnd();
		Singleton<Story>.Instance.JumpToStory(0u, dataId);
	}

	public void ResetScene()
	{
		bgController.Init();
		foreach (KeyValuePair<string, StoryActor> actor in actors)
		{
			actor.Value.Release();
		}
		actors.Clear();
		foreach (KeyValuePair<string, StoryEffect> effect in effects)
		{
			UnityEngine.Object.Destroy(effect.Value.gameObject);
		}
		effects.Clear();
		SetFadeIn(0f);
		headIcons.Clear();
		foreach (KeyValuePair<string, Animator> animator in animators)
		{
			UnityEngine.Object.Destroy(((Component)(object)animator.Value).gameObject);
		}
		animators.Clear();
		GameEntry.Resource.UnLoadSpriteGroup("StoryManager");
	}

	public void DoSceneChange(string bgName)
	{
		StartCoroutine(bgController.ChangeBG(GetBackGroundSprite(bgName), WindowSize));
	}

	public IEnumerator DoSceneChangeAsync(string bgName, float time)
	{
		yield return bgController.ChangeBG(GetBackGroundSprite(bgName), WindowSize, time);
	}

	public void FadeCurrentScene(float startAlpha = 0f, float endAlpha = 1f, float time = 0f)
	{
		StartCoroutine(bgController.FadeBG(startAlpha, endAlpha, time));
	}

	public IEnumerator FadeCurrentSceneAsync(float startAlpha = 0f, float endAlpha = 1f, float time = 0f)
	{
		yield return bgController.FadeBG(startAlpha, endAlpha, time);
	}

	public void MoveScene(string screenPosX = "0.5", string screenPosY = "0.5", float moveTime = 1f)
	{
		Vector2 a = new Vector2(0.5f, 0.5f);
		if (screenPosX != string.Empty && screenPosY != string.Empty)
		{
			a = new Vector2(ConvertCoordinates(screenPosX), ConvertCoordinates(screenPosY));
		}
		else if (screenPosX != string.Empty)
		{
			a.x = ConvertCoordinates(screenPosX);
		}
		a -= Vector2.one * 0.5f;
		StartCoroutine(MoveCoroutine(bgController.CurrentBG().rectTransform, Vector2.Scale(a, WindowSize), moveTime));
	}

	public IEnumerator MoveSceneAsync(string screenPosX = "0.5", string screenPosY = "0.5", float moveTime = 1f)
	{
		Vector2 a = new Vector2(0.5f, 0.5f);
		if (screenPosX != string.Empty && screenPosY != string.Empty)
		{
			a = new Vector2(ConvertCoordinates(screenPosX), ConvertCoordinates(screenPosY));
		}
		else if (screenPosX != string.Empty)
		{
			a.x = ConvertCoordinates(screenPosX);
		}
		a -= Vector2.one * 0.5f;
		yield return MoveCoroutine(bgController.CurrentBG().rectTransform, Vector2.Scale(a, WindowSize), moveTime);
	}

	public void ShakeScene(float shakeStrength = 0.2f)
	{
		StartCoroutine(SetShake(bgController.CurrentBG().rectTransform, shakeStrength));
	}

	public void SceneScale(float scale, float scaleTime = 1f)
	{
		StartCoroutine(ScaleCoroutine(bgController.CurrentBG().rectTransform, Vector3.one * scale, scaleTime));
	}

	public IEnumerator SceneScaleAsync(float scale, float scaleTime = 1f)
	{
		yield return ScaleCoroutine(bgController.CurrentBG().rectTransform, Vector3.one * scale, scaleTime);
	}

	public void SetSceneTime(string sceneName, string sceneTime)
	{
		((TMP_Text)sceneNameText).text = sceneName;
		((TMP_Text)sceneTimeText).text = sceneTime;
		sceneDetailRoot.SetTrigger("Open");
	}

	public void BlurScene(float stepVal, float time)
	{
		StartCoroutine(bgController.BlurCurrentScene(stepVal, time));
	}

	public void SetActor(string actorName, string spineName, string stateName = "idle", string positionX = "", string positionY = "", int layer = 0, string skinName = "default", string colorHex = "", string showType = "on")
	{
		Vector2 vector = new Vector2(0.5f, 0.5f);
		if (positionX != string.Empty)
		{
			vector.x = ConvertCoordinates(positionX);
		}
		if (positionY != string.Empty)
		{
			vector.y = ConvertCoordinates(positionY);
		}
		Color color = Color.white;
		if (colorHex != string.Empty)
		{
			ColorUtility.TryParseHtmlString(colorHex, out color);
		}
		if (skinName == "NSFWSKIN")
		{
			skinName = GetSkin();
		}
		if (!actors.TryGetValue(actorName, out var value))
		{
			SkeletonGraphic spineInstance = GetSpineInstance(spineName, vector, GetLayer(layer));
			if (!((UnityEngine.Object)(object)spineInstance == null))
			{
				value = new StoryActor(spineInstance);
				value.anchoredPosition = value.rectTransform.anchoredPosition;
				value.settingColor = color;
				actors.Add(actorName, value);
				value.SetActorState(stateName);
				value.SetSkin(skinName);
				ShowActorAnimate(value, showType);
			}
			return;
		}
		if (positionX == string.Empty && positionY == string.Empty)
		{
			vector = actors[actorName].rectTransform.anchoredPosition;
		}
		else if (positionY == string.Empty)
		{
			vector.y = actors[actorName].rectTransform.anchoredPosition.y;
		}
		value.rectTransform.SetParent(GetLayer(layer));
		value.anchoredPosition = Vector2.Scale(vector, WindowSize);
		value.rectTransform.anchoredPosition = value.anchoredPosition;
		value.settingColor = color;
		value.SetSpeed(DialogueGlobals.Speed);
		value.SetActorState(stateName);
		value.SetSkin(skinName);
		ShowActorAnimate(value, showType);
	}

	public void SetActorSpine(string actorName, string spineName, string stateName = "idle", string skinName = "default")
	{
		if (actors.TryGetValue(actorName, out var value))
		{
			SkeletonGraphic spineInstance = GetSpineInstance(spineName, Vector2.zero, value.rectTransform.parent.GetComponent<RectTransform>());
			if (!((UnityEngine.Object)(object)spineInstance == null))
			{
				value.anchoredPosition = value.rectTransform.anchoredPosition;
				value.SetSpine(spineInstance);
				value.SetActorState(stateName);
				value.SetSkin(skinName);
			}
		}
	}

	public void SetActorState(string actorName, string stateName)
	{
		if (actors.ContainsKey(actorName))
		{
			actors[actorName].SetActorState(stateName);
		}
	}

	public void SetActorSkin(string actorName, string skinName)
	{
		if (actors.ContainsKey(actorName))
		{
			actors[actorName].SetSkin(skinName);
		}
	}

	public void ShowActor(string actorName, float time = 0f)
	{
		if (actors.ContainsKey(actorName))
		{
			actors[actorName].Active();
			StartCoroutine(FadeCoroutine((Graphic)(object)actors[actorName].actorSpine, actors[actorName].ActorColor, 0f, 1f, time));
		}
	}

	public IEnumerator ShowActorAsync(string actorName, float time = 0f)
	{
		if (actors.ContainsKey(actorName))
		{
			actors[actorName].Active();
			yield return StartCoroutine(FadeCoroutine((Graphic)(object)actors[actorName].actorSpine, actors[actorName].ActorColor, 0f, 1f, time));
		}
	}

	public void HideActor(string actorName, float time = 0f)
	{
		if (actors.ContainsKey(actorName))
		{
			StartCoroutine(FadeCoroutine((Graphic)(object)actors[actorName].actorSpine, actors[actorName].ActorColor, -1f, 0f, time, delegate
			{
				actors[actorName].Inactive();
			}));
		}
	}

	public IEnumerator HideActorAsync(string actorName, float time = 0f)
	{
		if (actors.ContainsKey(actorName))
		{
			yield return StartCoroutine(FadeCoroutine((Graphic)(object)actors[actorName].actorSpine, actors[actorName].ActorColor, -1f, 0f, time, delegate
			{
				actors[actorName].Inactive();
			}));
		}
	}

	public void HideAllActor()
	{
		foreach (KeyValuePair<string, StoryActor> actor in actors)
		{
			actor.Value.Inactive();
		}
	}

	public void MoveActor(string actorName, string screenPosX = "0.5", string screenPosY = "0.5", float moveTime = 1f)
	{
		SkeletonGraphic val = FindActor(actorName);
		Vector2 a = new Vector2(0.5f, 0.5f);
		if (screenPosX != string.Empty && screenPosY != string.Empty)
		{
			a = new Vector2(ConvertCoordinates(screenPosX), ConvertCoordinates(screenPosY));
		}
		else if (screenPosX != string.Empty)
		{
			a.x = ConvertCoordinates(screenPosX);
		}
		StartCoroutine(MoveCoroutine(((Component)(object)val).GetComponent<RectTransform>(), Vector2.Scale(a, WindowSize), moveTime));
	}

	public IEnumerator MoveActorAsync(string actorName, string screenPosX = "0.5", string screenPosY = "0.5", float moveTime = 1f)
	{
		SkeletonGraphic val = FindActor(actorName);
		Vector2 a = new Vector2(0.5f, 0.5f);
		if (screenPosX != string.Empty && screenPosY != string.Empty)
		{
			a = new Vector2(ConvertCoordinates(screenPosX), ConvertCoordinates(screenPosY));
		}
		else if (screenPosX != string.Empty)
		{
			a.x = ConvertCoordinates(screenPosX);
		}
		yield return MoveCoroutine(((Component)(object)val).GetComponent<RectTransform>(), Vector2.Scale(a, WindowSize), moveTime);
	}

	public void FlipActor(string actorName, string xDirection = "")
	{
		SkeletonGraphic val = FindActor(actorName);
		float num = ((!(xDirection != string.Empty)) ? (Mathf.Sign(((Graphic)(object)val).rectTransform.localScale.x) * -1f) : Mathf.Sign(ConvertCoordinates(xDirection) - 0.5f));
		((Graphic)(object)val).rectTransform.localScale = new Vector3(num * Mathf.Abs(((Graphic)(object)val).rectTransform.localScale.x), ((Graphic)(object)val).rectTransform.localScale.y, ((Graphic)(object)val).rectTransform.localScale.z);
	}

	public void ShakeActor(string actorName, float shakeStrength = 0.5f)
	{
		SkeletonGraphic val = FindActor(actorName);
		if ((UnityEngine.Object)(object)val != null)
		{
			StartCoroutine(SetShake(((Graphic)(object)val).rectTransform, shakeStrength));
		}
	}

	public void SetActorLayer(string actorName, int layer)
	{
		if (actors.ContainsKey(actorName))
		{
			actors[actorName].rectTransform.SetParent(GetLayer(layer));
		}
	}

	public void SetActorScale(string actorName, float scale, float scaleTime = 1f)
	{
		if (actors.ContainsKey(actorName))
		{
			StartCoroutine(actors[actorName].SetScaleRatio(scale, scaleTime));
		}
	}

	public IEnumerator SetActorScaleAsync(string actorName, float scale, float scaleTime = 1f)
	{
		if (actors.ContainsKey(actorName))
		{
			yield return actors[actorName].SetScaleRatio(scale, scaleTime);
		}
	}

	public void SwitchActorAllState(string actorName, int state)
	{
		if (actors.ContainsKey(actorName))
		{
			actors[actorName].SwitchActorState(state);
		}
	}

	public void SwitchActorState(string actorName, string stateName, int state)
	{
		if (actors.ContainsKey(actorName))
		{
			actors[actorName].SwitchActorState(stateName, state);
		}
	}

	private void SetEffect(string effectName, string effectAssetName, int layer, string positionX = "", string positionY = "")
	{
		Vector2 vector = new Vector2(0.5f, 0.5f);
		if (positionX != string.Empty)
		{
			vector.x = ConvertCoordinates(positionX);
		}
		if (positionY != string.Empty)
		{
			vector.y = ConvertCoordinates(positionY);
		}
		if (!effects.TryGetValue(effectName, out var value))
		{
			value = GetEffectInstance(effectAssetName, GetLayer(layer), vector);
			if (!(value == null))
			{
				effects.Add(effectName, value);
			}
			return;
		}
		if (positionX == string.Empty && positionY == string.Empty)
		{
			vector = effects[effectName].RectTransform.anchoredPosition;
		}
		else if (positionY == string.Empty)
		{
			vector.y = effects[effectName].RectTransform.anchoredPosition.y;
		}
		value.SetSpeed(DialogueGlobals.Speed);
		value.RectTransform.SetParent(GetLayer(layer));
		value.RectTransform.anchoredPosition = Vector2.Scale(vector, WindowSize);
		value.SetActive(active: true);
	}

	public void ShowEffect(string effectName)
	{
		if (effects.ContainsKey(effectName))
		{
			effects[effectName].SetActive(active: true);
		}
	}

	public void HideEffect(string effectName)
	{
		if (effects.ContainsKey(effectName))
		{
			effects[effectName].SetActive(active: false);
		}
	}

	public void HideAllEffect()
	{
		foreach (KeyValuePair<string, StoryEffect> effect in effects)
		{
			effect.Value.SetActive(active: false);
		}
	}

	public void MoveEffect(string effectName, string screenPosX = "0.5", string screenPosY = "0.5", float moveTime = 1f)
	{
		StoryEffect storyEffect = FindEffect(effectName);
		Vector2 a = new Vector2(0.5f, 0.5f);
		if (screenPosX != string.Empty && screenPosY != string.Empty)
		{
			a = new Vector2(ConvertCoordinates(screenPosX), ConvertCoordinates(screenPosY));
		}
		else if (screenPosX != string.Empty)
		{
			a.x = ConvertCoordinates(screenPosX);
		}
		StartCoroutine(MoveCoroutine(storyEffect.GetComponent<RectTransform>(), Vector2.Scale(a, WindowSize), moveTime));
	}

	public IEnumerator MoveEffectAsync(string effectName, string screenPosX = "0.5", string screenPosY = "0.5", float moveTime = 1f)
	{
		StoryEffect storyEffect = FindEffect(effectName);
		Vector2 a = new Vector2(0.5f, 0.5f);
		if (screenPosX != string.Empty && screenPosY != string.Empty)
		{
			a = new Vector2(ConvertCoordinates(screenPosX), ConvertCoordinates(screenPosY));
		}
		else if (screenPosX != string.Empty)
		{
			a.x = ConvertCoordinates(screenPosX);
		}
		yield return MoveCoroutine(storyEffect.GetComponent<RectTransform>(), Vector2.Scale(a, WindowSize), moveTime);
	}

	public void FlipEffect(string effectName, string xDirection = "")
	{
		StoryEffect storyEffect = FindEffect(effectName);
		if (!(storyEffect == null))
		{
			float num = ((!(xDirection != string.Empty)) ? (Mathf.Sign(storyEffect.transform.localScale.x) * -1f) : Mathf.Sign(ConvertCoordinates(xDirection) - 0.5f));
			storyEffect.transform.localScale = new Vector3(num * Mathf.Abs(storyEffect.transform.localScale.x), storyEffect.transform.localScale.y, storyEffect.transform.localScale.z);
		}
	}

	public void SetFade(string fadeColorHex, float startAlpha = 0f, float endAlpha = 1f, float fadeTime = 1f)
	{
		if (!ColorUtility.TryParseHtmlString(fadeColorHex, out var color))
		{
			color = Color.magenta;
		}
		StartCoroutine(FadeCoroutine(fadeBG, color, startAlpha, endAlpha, fadeTime));
	}

	public void SetFadeIn(float fadeTime = 1f)
	{
		StartCoroutine(FadeCoroutine(fadeBG, fadeBG.color, -1f, 0f, fadeTime));
	}

	public void SetCameraOffset(string xPos = "", string yPos = "", float moveTime = 0.25f)
	{
		Vector2 vector = Vector2.zero;
		if (xPos != string.Empty && yPos != string.Empty)
		{
			vector = new Vector2(ConvertCoordinates(xPos) - 0.5f, ConvertCoordinates(xPos) - 0.5f);
		}
		else if (xPos != string.Empty)
		{
			vector.x = ConvertCoordinates(xPos) - 0.5f;
		}
		RectTransform component = spriteGroup.GetComponent<RectTransform>();
		Vector2 newAnchorPos = Vector2.Scale(new Vector2(0.5f, 0.5f) - vector, WindowSize);
		StartCoroutine(MoveCoroutine(component, newAnchorPos, moveTime));
	}

	public IEnumerator WaitTime(float time)
	{
		float elapsedTime = 0f;
		while (elapsedTime < time)
		{
			elapsedTime += Time.deltaTime * DialogueGlobals.Speed;
			yield return null;
		}
	}

	public void SetTypeSpeedRatio(float ratio)
	{
		DialogueGlobals.TypeSpeedRatio = ratio / 100f;
	}

	public void SetAutoHoldTime(float time)
	{
		lineView.holdTime = time;
	}

	private void SetAnimator(string animatorName, string stateName, int layer, int active)
	{
		if (!string.IsNullOrEmpty(animatorName))
		{
			if (!animators.TryGetValue(animatorName, out var value))
			{
				value = GetAnimatorInstance(animatorName, GetLayer(layer));
				animators.Add(animatorName, value);
			}
			((Component)(object)value).transform.SetParent(GetLayer(layer));
			value.Play(stateName);
			((Component)(object)value).gameObject.SetActive(active == 1);
		}
	}

	private void PlayAnimation(string animatorName, string stateName, int layer)
	{
		if (animators.TryGetValue(animatorName, out var value))
		{
			((Component)(object)value).transform.SetParent(GetLayer(layer));
			value.Play(stateName);
		}
	}

	private void SetAnimatorActive(string animatorName, int active)
	{
		if (animators.TryGetValue(animatorName, out var value))
		{
			((Component)(object)value).gameObject.SetActive(active == 1);
		}
	}

	public override void RunLine(LocalizedLine dialogueLine, Action onDialogueLineFinished)
	{
		//IL_019e: Unknown result type (might be due to invalid IL or missing references)
		string actorName = dialogueLine.CharacterName;
		int num = 0;
		if (!string.IsNullOrEmpty(dialogueLine.AudioId))
		{
			num = (int.TryParse(runner.CurrentNodeName + dialogueLine.AudioId, out var result) ? result : 0);
		}
		PlaySFX(num, out var voiceTime);
		lineView.voiceTime = voiceTime;
		if (!string.IsNullOrEmpty(actorName) && actors.ContainsKey(actorName))
		{
			HighlightSprite(actors[actorName].actorSpine);
			nameplateBG.color = actors[actorName].settingColor;
			nameplateBG.gameObject.SetActive(value: true);
		}
		else if (!string.IsNullOrEmpty(actorName) && !actors.ContainsKey(actorName))
		{
			InHighlightSprite();
			nameplateBG.color = Color.white;
			nameplateBG.gameObject.SetActive(value: true);
		}
		else
		{
			InHighlightSprite();
			nameplateBG.gameObject.SetActive(value: false);
		}
		DRPopupIcon dataRow = GameEntry.DataTable.GetDataRow((DRPopupIcon p) => p.IconId.Equals(actorName));
		string speakerName = actorName.Replace('-', ' ');
		string text = ((dataRow == null) ? "Emotion/1Moren.png" : dataRow.HeadPath);
		LoadHeadIcon(text);
		UpdateHappenedDialogues(new StoryDialogue
		{
			HeadIconUrl = text,
			HeadIcon = (string path) => (!headIcons.ContainsKey(path)) ? null : headIcons[path],
			SpeakerName = speakerName,
			Content = dialogueLine.TextWithoutCharacterName.Text,
			IsBranchOption = false,
			SaidByPlayer = (!string.IsNullOrEmpty(actorName) && actorName.Contains(StoryUtility.GetName())),
			IsAsides = string.IsNullOrEmpty(actorName),
			AudioId = num
		});
		onDialogueLineFinished();
	}

	public override void RunOptions(DialogueOption[] dialogueOptions, Action<int> onOptionSelected)
	{
		curDialogueOptions = dialogueOptions;
	}

	private void OnSelectAction(int optionIndex)
	{
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		DialogueOption[] array = curDialogueOptions;
		foreach (DialogueOption dialogueOption in array)
		{
			if (dialogueOption.DialogueOptionID == optionIndex)
			{
				UpdateHappenedDialogues(new StoryDialogue
				{
					SpeakerName = StoryUtility.GetName(),
					IsBranchOption = true,
					Content = dialogueOption.Line.Text.Text,
					SaidByPlayer = true,
					IsAsides = false
				});
			}
		}
	}

	private void UpdateHappenedDialogues(StoryDialogue dialogue)
	{
		happenedDialogues.Add(dialogue);
	}

	public void HighlightSprite(SkeletonGraphic spine)
	{
		StopCoroutine("HighlightActorCoroutine");
		StopCoroutine("InHighlightActorCoroutine");
		StartCoroutine("HighlightActorCoroutine", spine);
	}

	public void InHighlightSprite()
	{
		StopCoroutine("HighlightActorCoroutine");
		StopCoroutine("InHighlightActorCoroutine");
		StartCoroutine("InHighlightActorCoroutine");
	}

	private IEnumerator HighlightActorCoroutine(SkeletonGraphic highlightedSpine)
	{
		float t = 0f;
		while (t < 1f)
		{
			t += Time.deltaTime * DialogueGlobals.Speed / DialogueGlobals.ActorHighlightSpeed;
			foreach (StoryActor value in actors.Values)
			{
				Vector3 vector = new Vector3(Mathf.Sign(((Component)(object)value.actorSpine).transform.localScale.x), 1f, 1f);
				if ((UnityEngine.Object)(object)value.actorSpine != (UnityEngine.Object)(object)highlightedSpine)
				{
					((Component)(object)value.actorSpine).transform.localScale = Vector3.MoveTowards(((Component)(object)value.actorSpine).transform.localScale, vector * 0.95f * value.actorScaleRatio, t);
					value.ActorColor = Color.Lerp(value.ActorColor, defaultTint, t);
				}
				else
				{
					((Component)(object)value.actorSpine).transform.localScale = Vector3.MoveTowards(((Component)(object)value.actorSpine).transform.localScale, vector * value.actorScaleRatio, t);
					value.ActorColor = Color.Lerp(value.ActorColor, highlightTint, t);
					((Component)(object)value.actorSpine).transform.SetAsLastSibling();
				}
			}
			yield return 0;
		}
	}

	private IEnumerator InHighlightActorCoroutine()
	{
		float t = 0f;
		while (t < 1f)
		{
			t += Time.deltaTime * DialogueGlobals.Speed / DialogueGlobals.ActorHighlightSpeed;
			foreach (StoryActor value in actors.Values)
			{
				Vector3 vector = new Vector3(Mathf.Sign(((Component)(object)value.actorSpine).transform.localScale.x), 1f, 1f);
				((Component)(object)value.actorSpine).transform.localScale = Vector3.MoveTowards(((Component)(object)value.actorSpine).transform.localScale, vector * 0.95f * value.actorScaleRatio, t);
				value.ActorColor = Color.Lerp(value.ActorColor, defaultTint, t);
			}
			yield return 0;
		}
	}

	public void ShowActorAnimate(StoryActor actor, string showType)
	{
		if (showType == "frame")
		{
			actor.Active();
			StartCoroutine(FadeCoroutine((Graphic)(object)actor.actorSpine, actor.ActorColor, 0f, 1f, 1f));
		}
		else if (showType == "off")
		{
			actor.Inactive();
		}
		else
		{
			actor.Active();
			StartCoroutine(FadeCoroutine((Graphic)(object)actor.actorSpine, actor.ActorColor, 0f, 1f, 0f));
		}
	}

	private IEnumerator MoveCoroutine(RectTransform transform, Vector2 newAnchorPos, float moveTime)
	{
		IEnumerator<Vector2> dic = StoryUtility.Vector2Lerp(transform.anchoredPosition, newAnchorPos, moveTime);
		while (dic.MoveNext())
		{
			Vector2 current = dic.Current;
			transform.anchoredPosition = current;
			yield return null;
		}
		dic.Dispose();
	}

	private IEnumerator ScaleCoroutine(RectTransform transform, Vector3 targetScale, float scaleTime)
	{
		IEnumerator<Vector3> dic = StoryUtility.Vector3Lerp(transform.localScale, targetScale, scaleTime);
		while (dic.MoveNext())
		{
			Vector3 current = dic.Current;
			transform.localScale = current;
			yield return null;
		}
		dic.Dispose();
	}

	private IEnumerator FadeCoroutine(Graphic target, Color fadeColor, float startAlpha, float endAlpha, float fadeTime, Action action = null)
	{
		Color oriCol = fadeColor;
		if (startAlpha >= 0f)
		{
			oriCol.a = startAlpha;
		}
		else
		{
			oriCol = target.color;
		}
		fadeColor.a = endAlpha;
		if (fadeTime <= 0f)
		{
			target.color = fadeColor;
		}
		else
		{
			IEnumerator<Color> dic = StoryUtility.ColorLerp(oriCol, fadeColor, fadeTime);
			while (dic.MoveNext())
			{
				Color current = dic.Current;
				target.color = current;
				yield return null;
			}
			dic.Dispose();
		}
		action?.Invoke();
	}

	private IEnumerator RotationCoroutine(RectTransform transform, Vector3 targetRotation, float scaleTime)
	{
		IEnumerator<Vector3> dic = StoryUtility.Vector3Lerp(transform.rotation.eulerAngles, targetRotation, scaleTime);
		while (dic.MoveNext())
		{
			Vector3 current = dic.Current;
			transform.rotation = Quaternion.Euler(current);
			yield return null;
		}
		dic.Dispose();
	}

	private SkeletonGraphic GetSpineInstance(string actorName, Vector2 position, RectTransform layer)
	{
		SkeletonGraphic spine = GetSpine(actorName);
		if ((bool)(UnityEngine.Object)(object)spine)
		{
			SkeletonGraphic obj = UnityEngine.Object.Instantiate<SkeletonGraphic>(spine, (Transform)layer);
			((UnityEngine.Object)(object)obj).name = actorName;
			((Graphic)(object)obj).SetNativeSize();
			((Graphic)(object)obj).rectTransform.anchoredPosition = Vector2.Scale(position, WindowSize);
			return obj;
		}
		return null;
	}

	private SkeletonGraphic FindActor(string actorName)
	{
		if (actors.ContainsKey(actorName))
		{
			return actors[actorName].actorSpine;
		}
		return null;
	}

	private StoryEffect GetEffectInstance(string effectAssetName, Transform layer, Vector2 position)
	{
		StoryEffect effect = GetEffect(effectAssetName);
		if ((bool)effect)
		{
			StoryEffect storyEffect = UnityEngine.Object.Instantiate(effect, layer);
			storyEffect.name = effectAssetName;
			storyEffect.RectTransform.anchorMin = Vector2.zero;
			storyEffect.RectTransform.anchorMax = Vector2.zero;
			storyEffect.SetSpeed(DialogueGlobals.Speed);
			storyEffect.RectTransform.anchoredPosition = Vector2.Scale(position, WindowSize);
			return storyEffect;
		}
		return null;
	}

	private StoryEffect FindEffect(string effectName)
	{
		if (effects.ContainsKey(effectName))
		{
			return effects[effectName];
		}
		return null;
	}

	private IEnumerator SetShake(RectTransform thingToShake, float shakeStrength = 0.5f)
	{
		Vector2 startPos = thingToShake.anchoredPosition;
		while (shakeStrength > 0f)
		{
			shakeStrength -= Time.deltaTime * DialogueGlobals.Speed;
			float num = Mathf.Clamp(shakeStrength * 69f, 0f, 69f);
			float num2 = Mathf.Clamp(shakeStrength * 5f, 0f, 5f);
			thingToShake.anchoredPosition = startPos + num * new Vector2(Mathf.Sin(Time.time * num2), Mathf.Sin(Time.time * num2 + 17f) * 0.62f);
			yield return 0;
		}
		thingToShake.anchoredPosition = startPos;
	}

	private float ConvertCoordinates(string coordinate)
	{
		switch (coordinate.ToLower().Replace(" ", "").Replace("_", "")
			.Replace("-", ""))
		{
		case "leftedge":
		case "bottomedge":
		case "loweredge":
			return 0f;
		case "left":
		case "bottom":
		case "lower":
			return 0.25f;
		case "center":
		case "middle":
			return 0.5f;
		case "right":
		case "top":
		case "upper":
			return 0.75f;
		case "rightedge":
		case "topedge":
		case "upperedge":
			return 1f;
		case "offleft":
			return -0.33f;
		case "offright":
			return 1.33f;
		default:
		{
			if (float.TryParse(coordinate, out var result))
			{
				return result;
			}
			return -1f;
		}
		}
	}

	private RectTransform GetLayer(int layerIndex)
	{
		if (layers.Count <= layerIndex)
		{
			return layers[0];
		}
		return layers[layerIndex];
	}

	private Sprite GetBackGroundSprite(string bgName)
	{
		if ((bool)(UnityEngine.Object)(object)assets && assets.backgroundSprites.TryGetValue(bgName, out var value))
		{
			return value;
		}
		return null;
	}

	private SkeletonGraphic GetSpine(string actorName)
	{
		if ((bool)(UnityEngine.Object)(object)assets && assets.spineAnimations.TryGetValue(actorName, out var value))
		{
			return value;
		}
		return null;
	}

	private StoryEffect GetEffect(string effectName)
	{
		if ((bool)(UnityEngine.Object)(object)assets && assets.effectResources.TryGetValue(effectName, out var value))
		{
			return value;
		}
		return null;
	}

	private Animator GetAnimator(string animatorName)
	{
		if ((bool)(UnityEngine.Object)(object)assets && assets.animatorResources.TryGetValue(animatorName, out var value))
		{
			return value;
		}
		return null;
	}

	private Animator GetAnimatorInstance(string animatorName, RectTransform layer)
	{
		Animator animator = GetAnimator(animatorName);
		if ((bool)(UnityEngine.Object)(object)animator)
		{
			Animator obj = UnityEngine.Object.Instantiate<Animator>(animator, (Transform)layer);
			((UnityEngine.Object)(object)obj).name = animatorName;
			return obj;
		}
		return null;
	}

	public void SetSpeed(bool fast)
	{
		float speed = (DialogueGlobals.Speed = (fast ? fastSpeed : 1f));
		foreach (KeyValuePair<string, StoryActor> actor in actors)
		{
			actor.Value.SetSpeed(speed);
		}
		foreach (KeyValuePair<string, StoryEffect> effect in effects)
		{
			effect.Value.SetSpeed(speed);
		}
		GameEntry.Setting.SetBool("剧情倍速", fast);
		GameEntry.Setting.Save();
	}

	public void SetAutoState(bool auto)
	{
		lineView.SetAutoState(auto);
		GameEntry.Setting.SetBool("剧情自动", auto);
		GameEntry.Setting.Save();
	}

	public void RestState()
	{
		curDialogueOptions = null;
		happenedDialogues.Clear();
		DialogueGlobals.TypeSpeedRatio = 0f;
	}

	public void SetFilmScene(int isOn)
	{
		FilmBG?.gameObject.SetActive(isOn == 1);
	}

	public void SetMovieStyle(string animatorName, string stateName)
	{
		try
		{
			GameObject.Find(animatorName).GetComponent<Animator>().Play(stateName);
		}
		catch (Exception message)
		{
			Log.Error(message);
		}
	}

	public void SetSceneRotation(string name, float x, float y, float z, float time)
	{
		if (bgController != null)
		{
			bgController.SetSceneRotation(name, x, y, z, time);
		}
	}

	public void SetActorRotation(string actorName, float x, float y, float z, float time)
	{
		if (actors.ContainsKey(actorName))
		{
			StartCoroutine(RotationCoroutine(actors[actorName].rectTransform, new Vector3(x, y, z), time));
		}
	}

	public void SetCRTColor(string actorName, string colorHex, float alpha)
	{
		if (!ColorUtility.TryParseHtmlString(colorHex, out var color))
		{
			color = Color.magenta;
		}
		color.a = alpha;
		if (!actors.ContainsKey(actorName))
		{
			return;
		}
		GameObject actorState = actors[actorName].GetActorState("CRT");
		if (actorState != null && actorState.transform.Find("color") != null)
		{
			Image component = actorState.transform.Find("color").GetComponent<Image>();
			if (component != null)
			{
				component.color = color;
			}
		}
	}

	public int GetCharacter()
	{
		return StoryUtility.GetCharacterIndex();
	}

	public string GetSkin()
	{
		return StoryUtility.GetStreamerMode();
	}

	public async void LoadHeadIcon(string icon)
	{
		if (!string.IsNullOrEmpty(icon) && !headIcons.ContainsKey(icon))
		{
			headIcons.Add(icon, null);
			Sprite value = await GameEntry.Resource.LoadSpriteAsync(AssetUtility.GetFGImageSprite(icon), "StoryManager");
			headIcons[icon] = value;
		}
	}

	public void PlayBGM(int id, float volume = 1f, float fadeInTime = 3f, float fadeOutTime = 3f, string key = "", float value = 0f, float duration = 0f)
	{
		//IL_0070: Unknown result type (might be due to invalid IL or missing references)
		DRAudio dataRow = GameEntry.DataTable.GetDataRow<DRAudio>(id);
		if (dataRow == null)
		{
			return;
		}
		paramList.Clear();
		if (!string.IsNullOrEmpty(key))
		{
			paramList.Add(new AudioParameter
			{
				key = key,
				targetVal = value,
				duration = duration
			});
		}
		try
		{
			Singleton<AudioSystem>.Instance.PlayStoryBGM(id, dataRow.EventPath, dataRow.EventType, volume, paramList, canReturn: true, (STOP_MODE)0, fadeInTime);
		}
		catch (Exception)
		{
		}
	}

	public void StopBGM(int id, float fadeInTime = 3f, float fadeOutTime = 3f)
	{
		try
		{
			Singleton<AudioSystem>.Instance.StopStoryBGM(fadeInTime, fadeOutTime);
		}
		catch (Exception)
		{
		}
	}

	public void ClearStoryBGM()
	{
		try
		{
			Singleton<AudioSystem>.Instance.ClearStoryBGM();
		}
		catch (Exception)
		{
		}
	}

	public void PlaySFX(int id, float volume = 1f, string key = "", float value = 0f, float duration = 0f)
	{
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0070: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		DRAudio dataRow = GameEntry.DataTable.GetDataRow<DRAudio>(id);
		if (dataRow == null)
		{
			return;
		}
		paramList.Clear();
		if (!string.IsNullOrEmpty(key))
		{
			paramList.Add(new AudioParameter
			{
				key = key,
				targetVal = value,
				duration = duration
			});
		}
		try
		{
			EventInstance value2 = Singleton<AudioSystem>.Instance.Play(id, dataRow.EventPath, dataRow.EventType, volume, paramList);
			eventInstances.Add(id, value2);
		}
		catch (Exception)
		{
		}
	}

	public void StopSFX(int id)
	{
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		try
		{
			if (eventInstances.TryGetValue(id, out var value))
			{
				Singleton<AudioSystem>.Instance.Stop(value);
				eventInstances.Remove(id);
			}
		}
		catch (Exception)
		{
		}
	}

	public void PlaySFX(int id, out int voiceTime)
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		voiceTime = 1;
		StopSFX();
		if (GameEntry.DataTable.GetDataRow<DRAudio>(id) == null)
		{
			return;
		}
		try
		{
			sfxEventInstance = Singleton<AudioSystem>.Instance.CreateInstance(id);
			((EventInstance)(ref sfxEventInstance)).start();
			EventDescription val = default(EventDescription);
			((EventInstance)(ref sfxEventInstance)).getDescription(ref val);
			int num = default(int);
			((EventDescription)(ref val)).getLength(ref num);
			voiceTime = num;
		}
		catch (Exception)
		{
		}
	}

	public void StopSFX()
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		try
		{
			if (((EventInstance)(ref sfxEventInstance)).isValid())
			{
				Singleton<AudioSystem>.Instance.Stop(sfxEventInstance);
				((EventInstance)(ref sfxEventInstance)).stop((STOP_MODE)0);
			}
		}
		catch (Exception)
		{
		}
	}

	public StoryManager()
	{
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		layers = new List<RectTransform>();
		actors = new Dictionary<string, StoryActor>();
		effects = new Dictionary<string, StoryEffect>();
		happenedDialogues = new List<StoryDialogue>();
		headIcons = new Dictionary<string, Sprite>();
		animators = new Dictionary<string, Animator>();
		paramList = new List<AudioParameter>();
		eventInstances = new Dictionary<int, EventInstance>();
		sfxEventInstance = new EventInstance(IntPtr.Zero);
		base._002Ector();
	}
}
