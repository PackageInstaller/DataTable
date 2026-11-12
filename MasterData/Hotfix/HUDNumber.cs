using System;
using System.Collections.Generic;
using Nova.Hotfix;
using TMPro;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using UnityEngine.UI;

[DisallowMultipleComponent]
[RequireComponent(typeof(HUDFollowTarget))]
public class HUDNumber : MonoBehaviour, IAdventureHUD
{
	public delegate void HudHandle(float dt);

	public List<TMP_Text> texList = new List<TMP_Text>();

	public TMP_Text text;

	public HUDNumberConfig config;

	public char[] _chars = new char[32];

	public int Id;

	[Space]
	public bool stretchedScale;

	public int randomArrow;

	private HUDFollowTarget _followTarget;

	private bool _textAnimDirty;

	private float _animTimer;

	private float continueTime;

	private Vector3 _animADSRTimer;

	private List<Vector3> _cacheTextVertices;

	private GameObject objShield;

	public Image imageShield;

	public event HudHandle TextFinish;

	public event HudHandle TextFadeIn;

	private void Awake()
	{
		_followTarget = gameObject.AddOrGetComponent<HUDFollowTarget>();
		text = texList.get_Item(0);
	}

	private void OnEnable()
	{
		SceneSingleton<AdventureHUDController>.Instance.AddHud(this);
	}

	private void OnDisable()
	{
		if (objShield != null)
		{
			objShield.SetActive(value: false);
			objShield = null;
			imageShield = null;
		}
		text.gameObject.SetActive(value: false);
		SceneSingleton<AdventureHUDController>.Instance?.RemoveHud(this);
	}

	public void HUDUpdate(float dt)
	{
		_followTarget?.HUDUpdate(dt);
		if (_textAnimDirty)
		{
			_textAnimDirty = false;
			ResetTextAnimation();
		}
		TextAnimationUpdate(dt);
	}

	private void CacheTextMesh()
	{
		TMP_TextInfo textInfo = text.textInfo;
		int characterCount = textInfo.characterCount;
		if (_cacheTextVertices == null)
		{
			_cacheTextVertices = new List<Vector3>(characterCount * 4);
		}
		else
		{
			_cacheTextVertices.Clear();
			if (_cacheTextVertices.Capacity < characterCount * 4)
			{
				_cacheTextVertices.Capacity = characterCount * 4;
			}
		}
		for (int i = 0; i < characterCount; i++)
		{
			int materialReferenceIndex = textInfo.characterInfo[i].materialReferenceIndex;
			Vector3[] vertices = textInfo.meshInfo[materialReferenceIndex].vertices;
			_ = ref textInfo.meshInfo[materialReferenceIndex];
			int vertexIndex = textInfo.characterInfo[i].vertexIndex;
			_cacheTextVertices.Add(vertices[vertexIndex]);
			_cacheTextVertices.Add(vertices[vertexIndex + 1]);
			_cacheTextVertices.Add(vertices[vertexIndex + 2]);
			_cacheTextVertices.Add(vertices[vertexIndex + 3]);
		}
	}

	private void ResetTextAnimation()
	{
		_animTimer = 0f;
		continueTime = UnityEngine.Random.Range(config.continueTimeMin, config.continueTimeMax);
		_animADSRTimer.x = 0f;
		_animADSRTimer.y = 0f;
		_animADSRTimer.z = 0f;
		text.ForceMeshUpdate();
		CacheTextMesh();
	}

	private void TextAnimationUpdate(float dt)
	{
		_animTimer += dt;
		if (_animTimer > continueTime)
		{
			TextFinish?.Invoke(dt);
		}
		else
		{
			TextFadeIn?.Invoke(dt);
		}
	}

	public float GetFadeInNormalizedTime(float dt)
	{
		_animADSRTimer.x += dt;
		return Mathf.Clamp01(_animADSRTimer.x / continueTime);
	}

	public void TextFadeInUpdate(float dt, float normalizedTime)
	{
		if (randomArrow != 2)
		{
			text.transform.localPosition = new Vector3(config.translateCurveX.Evaluate(normalizedTime) * config.translateCurveScaleX, config.translateCurveY.Evaluate(normalizedTime) * config.translateCurveScaleY, normalizedTime);
		}
		else
		{
			text.transform.localPosition = new Vector3((0f - config.translateCurveX.Evaluate(normalizedTime)) * config.translateCurveScaleX, config.translateCurveY.Evaluate(normalizedTime) * config.translateCurveScaleY, normalizedTime);
		}
		float textScale = config.scaleCurve.Evaluate(normalizedTime) * config.scaleCurveScale;
		SetTextScale(textScale);
		text.color = config.texGradient.Evaluate(normalizedTime);
		if (imageShield != null)
		{
			imageShield.color = config.texGradient.Evaluate(normalizedTime);
		}
	}

	public void TextFadeOutUpdate(float dt, float normalizedTime)
	{
		text.transform.localPosition = new Vector3(0f, config.fadeOutTranslateCurve.Evaluate(normalizedTime) * config.fadeOutTranslateCurveScale, 0f);
		float textScale = config.fadeOutScaleCurve.Evaluate(normalizedTime) * config.fadeOutScaleCurveScale;
		SetTextScale(textScale);
		text.color = config.fadeOutGradient.Evaluate(normalizedTime);
		if (imageShield != null)
		{
			imageShield.color = config.fadeOutGradient.Evaluate(normalizedTime);
		}
	}

	private void SetTextScale(float textScale)
	{
		if (stretchedScale)
		{
			text.transform.localScale = new Vector3(1f / textScale, textScale, 1f);
		}
		else
		{
			text.transform.localScale = new Vector3(textScale, textScale, 1f);
		}
	}

	public void SetToughnessDamageValue(int id, string val, Transform target, float xOffset, float yOffset, bool useVariant, bool isChange)
	{
		if (!isChange)
		{
			Id = id;
			int arrow = UnityEngine.Random.Range(0, 3);
			_followTarget?.SetFollowTarget(target, GetPostionOffset(xOffset, yOffset, arrow, isDot: false));
			text = texList.get_Item(0);
			text.gameObject.SetActive(value: true);
			for (int i = 0; i < texList.Count; i++)
			{
				texList.get_Item(i).SetText(val);
			}
			Refresh();
		}
		else
		{
			text = texList.get_Item(0);
			for (int j = 0; j < texList.Count; j++)
			{
				texList.get_Item(j).SetText(val);
			}
		}
	}

	public void SetStringValue(int id, string val, int valType, Transform target, float xOffset, float yOffset, bool useVariant)
	{
		Id = id;
		int arrow = UnityEngine.Random.Range(0, 3);
		_followTarget?.SetFollowTarget(target, GetPostionOffset(xOffset, yOffset, arrow, isDot: false));
		for (int i = 0; i < texList.Count; i++)
		{
			texList.get_Item(i).gameObject.SetActive(i == valType - 1);
		}
		text = texList.get_Item(valType - 1);
		text.gameObject.SetActive(value: true);
		text.SetText(val);
		Refresh();
	}

	public void SetValue(int id, long val, bool isHeal, LogicEntity entity, float xOffset, float yOffset, HitDamage hitDamage, long formEntityId, bool isCrit, bool isDot, int fromElementType, int hudColorIndex)
	{
		Id = id;
		int num = 7;
		bool flag = entity.GetComponent<PlayerAdventureActor>() != null;
		randomArrow = 0;
		int num2 = 0;
		if (!isHeal)
		{
			HotfixEnum.elementType elementType = HotfixEnum.elementType.NONE;
			if (!flag && hitDamage != null && hitDamage.EffectType != 4 && entity is AdventureActor)
			{
				elementType = (HotfixEnum.elementType)hitDamage.ElementType;
				if (elementType == HotfixEnum.elementType.INHERIT && formEntityId != 0L)
				{
					elementType = (HotfixEnum.elementType)fromElementType;
				}
			}
			num = hudColorIndex;
			if (formEntityId != 0L)
			{
				LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(formEntityId);
				if (logicEntity != null)
				{
					Vector3 vector = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.WorldToScreenPointAsHFOV(entity.transform.position);
					Vector3 vector2 = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.WorldToScreenPointAsHFOV(logicEntity.transform.position);
					if (vector.x > vector2.x)
					{
						randomArrow = 1;
					}
					else
					{
						randomArrow = 2;
					}
				}
			}
			num = ExpandColorIndexByCrit(num, isCrit);
			if (hitDamage != null && hitDamage.DamageType == 5)
			{
				num2 = (int)elementType;
				if (num2 < 0 || num2 > 6)
				{
					num2 = 0;
				}
			}
		}
		else
		{
			num = 10;
		}
		Refresh();
		_followTarget?.SetFollowTarget(entity.transform, GetPostionOffset(xOffset, yOffset, randomArrow, isDot));
		text.gameObject.SetActive(value: true);
		SetText(val, num, num2);
	}

	private static int ExpandColorIndexByCrit(int hudColorIndex, bool isCrit)
	{
		if (!isCrit)
		{
			return hudColorIndex * 2 - 2;
		}
		return hudColorIndex * 2 - 1;
	}

	public void RefreshMergedValue(long val, int hudColorIndex)
	{
		SetText(val, ExpandColorIndexByCrit(hudColorIndex, isCrit: false), 0);
		ResetTextAnimation();
	}

	public void SetText(long value, int type, int elementType)
	{
		int num = 0;
		long num2 = value;
		while (value > 0)
		{
			num++;
			value /= 10;
		}
		if (elementType > 0)
		{
			num++;
		}
		if (num > _chars.Length)
		{
			_chars = new char[num];
		}
		int num3 = 0;
		if (elementType > 0)
		{
			elementType--;
			num3 = 1;
			_chars[0] = Convert.ToChar(48 + elementType + 110 + 38598);
		}
		for (int num4 = num - 1; num4 >= num3; num4--)
		{
			long num5 = num2 % 10;
			_chars[num4] = (char)(48 + num5 + 10 * type + 38598);
			num2 /= 10;
		}
		text.SetText(_chars, 0, num);
	}

	private Vector3 GetPostionOffset(float xOffset, float yOffset, int _arrow, bool isDot)
	{
		float num = yOffset;
		float num2 = UnityEngine.Random.Range(config.starPosYRange.x, config.starPosYRange.y);
		float num3 = UnityEngine.Random.Range(config.starPosXRange.x, config.starPosXRange.y);
		if (!isDot)
		{
			num = num2 * num;
		}
		else if (SceneSingleton<AdventureHUDController>.Instance.hudDotLastXPos.ContainsKey(Id))
		{
			num = SceneSingleton<AdventureHUDController>.Instance.hudDotLastXPos.get_Item((long)Id) / 2f;
			SceneSingleton<AdventureHUDController>.Instance.hudDotLastXPos.set_Item((long)Id, num);
		}
		else
		{
			num = 0.6f * num;
			SceneSingleton<AdventureHUDController>.Instance.hudDotLastXPos.set_Item((long)Id, num);
		}
		if (_arrow < 2)
		{
			return new Vector3((0f - xOffset) * num3, num, 0f);
		}
		return new Vector3(xOffset * num3, num, 0f);
	}

	private void Refresh()
	{
		text.transform.localPosition = Vector3.zero;
		text.transform.localRotation = Quaternion.identity;
		text.transform.localScale = Vector3.one;
		_textAnimDirty = true;
	}
}
