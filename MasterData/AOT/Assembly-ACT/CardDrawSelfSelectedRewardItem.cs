using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

public class CardDrawSelfSelectedRewardItem : MonoBehaviour
{
	public BImage ImageCharacterCard;

	public GameObject GoCharacterCardMask;

	public GameObject GoSelect;

	public BImage ImageQuality;

	public CharacterProfessionIcon ImageProfession;

	public LocalizeStringEvent TextName;

	public ActButton BtnClick;

	public int id;

	public GachaItem GachaItem;

	public GameObject GoNotGet;

	public GameObject GodestinyNum;

	public TextMeshProUGUI TextdestinyNum;

	public List<CharacterOverTagtem> _listTag;

	public CharacterMannerItem MannerItem;

	public Color SelectNameColor = Color.black;

	public Color NormalNameColor = Color.white;

	private ImageAssetStation _station;

	private int characterId;

	private TextMeshProUGUI _textName;

	private bool _isSelected;

	[SerializeField]
	[Min(1f)]
	private float _scaleSpringFrequency = 16f;

	[SerializeField]
	[Range(0.1f, 1f)]
	private float _scaleSpringDamping = 0.55f;

	private Vector3 _targetScale;

	private Vector3 _smoothedScale;

	private Vector3 _scaleVelocity;

	private Vector3 _lastAppliedScale;

	private float _lastLayoutScaleX;

	private void OnEnable()
	{
		_targetScale = transform.localScale;
		_smoothedScale = _targetScale;
		_lastAppliedScale = _targetScale;
		_scaleVelocity = Vector3.zero;
		_lastLayoutScaleX = _targetScale.x;
	}

	private void LateUpdate()
	{
		Vector3 localScale = transform.localScale;
		if (!Approximately(localScale, _lastAppliedScale))
		{
			_targetScale = localScale;
		}
		SimulateScale(Time.unscaledDeltaTime);
		transform.localScale = _smoothedScale;
		_lastAppliedScale = _smoothedScale;
		if (!Mathf.Approximately(_smoothedScale.x, _lastLayoutScaleX))
		{
			_lastLayoutScaleX = _smoothedScale.x;
			if (transform.parent is RectTransform rect)
			{
				LayoutRebuilder.MarkLayoutForRebuild(rect);
			}
		}
	}

	private void SimulateScale(float deltaTime)
	{
		if (deltaTime <= 0f)
		{
			return;
		}
		deltaTime = Mathf.Min(deltaTime, 0.05f);
		if (Approximately(_smoothedScale, _targetScale))
		{
			_smoothedScale = _targetScale;
			_scaleVelocity = Vector3.zero;
			return;
		}
		float num = deltaTime;
		float num2 = MathF.PI * 2f * _scaleSpringFrequency;
		while (num > 0f)
		{
			float num3 = Mathf.Min(num, 0.01f);
			Vector3 vector = _smoothedScale - _targetScale;
			Vector3 vector2 = (0f - num2) * num2 * vector - 2f * _scaleSpringDamping * num2 * _scaleVelocity;
			_scaleVelocity += vector2 * num3;
			_smoothedScale += _scaleVelocity * num3;
			num -= num3;
		}
		if (Vector3.SqrMagnitude(_targetScale - _smoothedScale) < 1E-08f && _scaleVelocity.sqrMagnitude < 1E-06f)
		{
			_smoothedScale = _targetScale;
			_scaleVelocity = Vector3.zero;
		}
	}

	private static bool Approximately(Vector3 a, Vector3 b)
	{
		if (Mathf.Approximately(a.x, b.x) && Mathf.Approximately(a.y, b.y))
		{
			return Mathf.Approximately(a.z, b.z);
		}
		return false;
	}

	public void RefreshDestinyNum()
	{
		IList<object> list = new List<object>();
		int maxCommonDestinyCount = Model<DestinyModel>.Interface.GetMaxCommonDestinyCount();
		int num = maxCommonDestinyCount - Model<DestinyModel>.Interface.GetCharacterCouldGetDestinyCostCount(characterId);
		list.Add(num);
		list.Add(maxCommonDestinyCount.ToString());
		TextdestinyNum.text = LocalizationUtility.GetLocalizeString("Common", 2159, list);
	}

	public void Init(GachaItem item, ImageAssetStation station)
	{
		id = item.id;
		GachaItem = item;
		_station = station;
		ItemData data = CoreUtils.GetData(item.itemId, RuntimeConfigs.data.itemDatas);
		characterId = data.canBeTransited[0].id;
		EntityCharacterData data2 = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		EntityData data3 = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityDatas);
		if (data2 != null)
		{
			ImageProfession.UpdateDisPlay(characterId);
			MannerItem?.Init(_station, data2.mannerType);
			int[] characterTagGroup = data2.characterTagGroup;
			if (_listTag != null)
			{
				for (int i = 0; i < _listTag.Count; i++)
				{
					_listTag[i].gameObject.SetActive(characterTagGroup.Length > i);
					if (characterTagGroup.Length > i)
					{
						_listTag[i].Init(characterTagGroup[i]);
						_listTag[i].BtnClick.SetBtnClick(() =>
						{
							Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERTAGDETAILS, new CharacterTagDetailsViewData
							{
								characterId = characterId
							});
						});
					}
				}
			}
		}
		if (data3 != null)
		{
			TextName.StringReference.TableEntryReference = data3.nameLocal;
			_station.LoadImage(176, data2.stars, ImageQuality);
		}
		_station.LoadImage(149, characterId, ImageCharacterCard);
		if (_textName == null && TextName != null)
		{
			_textName = TextName.GetComponent<TextMeshProUGUI>();
		}
		SetSelected(selected: false);
		Refresh();
	}

	public void SetSelected(bool selected)
	{
		if (selected != _isSelected)
		{
			if (GoSelect != null)
			{
				GoSelect.SetActive(selected);
			}
			if (GoCharacterCardMask != null)
			{
				GoCharacterCardMask.SetActive(!selected);
			}
			if (_textName == null && TextName != null)
			{
				_textName = TextName.GetComponent<TextMeshProUGUI>();
			}
			if (_textName != null)
			{
				_textName.color = (selected ? SelectNameColor : NormalNameColor);
			}
			if (selected)
			{
				GetComponent<BetterAnimation>().GetSequence("Select").Play();
			}
			else
			{
				GetComponent<BetterAnimation>().GetSequence("Normal").Play();
			}
			_isSelected = selected;
		}
	}

	public void Refresh()
	{
		if (GameUtility.CheckIsHaveCharacter(characterId))
		{
			GoNotGet.SetActive(value: false);
			GodestinyNum.SetActive(value: true);
			RefreshDestinyNum();
		}
		else
		{
			GoNotGet.SetActive(value: true);
			GodestinyNum.SetActive(value: false);
		}
	}
}
