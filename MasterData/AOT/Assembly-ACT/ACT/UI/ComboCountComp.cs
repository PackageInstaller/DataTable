using System;
using System.Collections.Generic;
using ACT.Battle;
using Bamboo.ECS;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class ComboCountComp : MonoBehaviour, IBattleMainComponent
{
	[Serializable]
	private class CountStageParam
	{
		public int startCount;

		public Color color;
	}

	[SerializeField]
	private DamageNumberConfig config;

	[SerializeField]
	private BetterAnimation animation;

	[SerializeField]
	private Image[] comboCountText;

	[SerializeField]
	private GameObject[] ChangeApprenceObjs;

	[SerializeField]
	private CountStageParam[] count2Color;

	[SerializeField]
	private Slider comboTimeSlider;

	[SerializeField]
	private BetterAnimation betterAnimation;

	[SerializeField]
	private TextMeshProUGUI dmgNumber;

	private int _comboCount;

	private int _countStage = -1;

	private bool _show;

	private int digits;

	private List<Image> cachedImages = new List<Image>();

	private List<ParticleSystem> cachedParticles = new List<ParticleSystem>();

	private const string ComboColorChangeEx = "ComboColorEx";

	private const string ComboChange = "Combo";

	private bool isInComboTime => GameManager.comboCountSystem.InCombo;

	public void Initialize(MonoBattleMainBaseView view)
	{
		SystemComboCount comboCountSystem = GameManager.comboCountSystem;
		comboTimeSlider.minValue = 0f;
		comboTimeSlider.maxValue = comboCountSystem.ClearTime;
		CachedApprenceChangeComponents();
		comboCountSystem.OnComboCountChange = (Action<int, int>)Delegate.Combine(comboCountSystem.OnComboCountChange, new Action<int, int>(SetComboCount));
		comboCountSystem.ChangeComboImageWhenUnHited = (Action<int>)Delegate.Combine(comboCountSystem.ChangeComboImageWhenUnHited, new Action<int>(ChangeComboImageWhenUnHited));
		comboCountSystem.OnDmgChange = (Action<int>)Delegate.Combine(comboCountSystem.OnDmgChange, new Action<int>(SetDmg));
		gameObject.SetActive(isInComboTime);
	}

	public void UnInitialize()
	{
		SystemComboCount comboCountSystem = GameManager.comboCountSystem;
		comboCountSystem.OnComboCountChange = (Action<int, int>)Delegate.Remove(comboCountSystem.OnComboCountChange, new Action<int, int>(SetComboCount));
		comboCountSystem.ChangeComboImageWhenUnHited = (Action<int>)Delegate.Remove(comboCountSystem.ChangeComboImageWhenUnHited, new Action<int>(ChangeComboImageWhenUnHited));
		comboCountSystem.OnDmgChange = (Action<int>)Delegate.Remove(comboCountSystem.OnDmgChange, new Action<int>(SetDmg));
		cachedImages.Clear();
		cachedParticles.Clear();
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	private void CachedApprenceChangeComponents()
	{
		GameObject[] changeApprenceObjs = ChangeApprenceObjs;
		if (changeApprenceObjs == null || changeApprenceObjs.Length <= 0)
		{
			return;
		}
		changeApprenceObjs = ChangeApprenceObjs;
		foreach (GameObject gameObject in changeApprenceObjs)
		{
			if (gameObject.TryGetComponent<Image>(out var component))
			{
				cachedImages.Add(component);
				continue;
			}
			ParticleSystem[] componentsInChildren = gameObject.GetComponentsInChildren<ParticleSystem>(includeInactive: true);
			foreach (ParticleSystem item in componentsInChildren)
			{
				cachedParticles.Add(item);
			}
		}
	}

	private void SetComboCount(int oldCount, int newCount)
	{
		SystemAbility abilitySystem = GameManager.abilitySystem;
		Entity mainEntity = MonoECS.instance.mainEntity;
		EvtComboCountChange evt = abilitySystem.GetEvt<EvtComboCountChange>(mainEntity, null);
		evt.mainEntity = mainEntity;
		evt.ownerEntity = mainEntity;
		evt.oldComboCount = oldCount;
		evt.newComboCount = newCount;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		if (oldCount == 0 && newCount > 0)
		{
			gameObject.SetActive(isInComboTime);
		}
		else if (oldCount > 0 && newCount == 0)
		{
			gameObject.SetActive(isInComboTime);
			_countStage = -1;
			return;
		}
		bool flag = CheckStageChange(newCount, _countStage, out var newStageIfChanged, out var newColorIfChanged);
		if (flag)
		{
			_countStage = newStageIfChanged;
			betterAnimation?.GetSequence("ComboColorEx").Play();
		}
		else
		{
			betterAnimation?.GetSequence("Combo").Play();
		}
		digits = GetDamageNumDigits(newCount, comboCountText.Length);
		if (flag)
		{
			List<Image> list = cachedImages;
			if (list != null && list.Count > 0)
			{
				foreach (Image cachedImage in cachedImages)
				{
					cachedImage.color = newColorIfChanged;
				}
			}
			List<ParticleSystem> list2 = cachedParticles;
			if (list2 != null && list2.Count > 0)
			{
				foreach (ParticleSystem cachedParticle in cachedParticles)
				{
					cachedParticle.Clear();
					ParticleSystem.MainModule main = cachedParticle.main;
					main.startColor = newColorIfChanged;
				}
			}
		}
		Sprite[] array = config.comboNumNormalSprites[newStageIfChanged];
		if (array == null || array.Length <= 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"combo 在 等级{newStageIfChanged} 图片配置缺失，检查DamageNumberConfig的配置");
			}
			return;
		}
		for (int num = digits - 1; num >= 0; num--)
		{
			comboCountText[num].enabled = true;
			comboCountText[num].sprite = array[newCount % 10];
			newCount /= 10;
		}
		if (digits < comboCountText.Length)
		{
			for (int i = digits; i < comboCountText.Length; i++)
			{
				comboCountText[i].enabled = false;
			}
		}
	}

	private void ChangeComboImageWhenUnHited(int newCount)
	{
		int stage = GetStage(newCount);
		Sprite[] array = config.comboNumNormalSprites[stage];
		if (array == null || array.Length <= 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"combo 在 等级{stage} 图片配置缺失，检查DamageNumberConfig的配置");
			}
			return;
		}
		for (int num = digits - 1; num >= 0; num--)
		{
			comboCountText[num].sprite = array[newCount % 10];
			newCount /= 10;
		}
	}

	private int GetDamageNumDigits(int damage, int maxDigits)
	{
		return Mathf.Clamp(1 + (int)Mathf.Floor(Mathf.Log10(damage)), 0, maxDigits);
	}

	private Color GetColor(int stage)
	{
		return count2Color[stage].color;
	}

	private bool CheckStageChange(int newCount, int curStage, out int newStageIfChanged, out Color newColorIfChanged)
	{
		int stage = GetStage(newCount);
		if (curStage != stage)
		{
			newStageIfChanged = stage;
			newColorIfChanged = GetColor(stage);
			return true;
		}
		newStageIfChanged = curStage;
		newColorIfChanged = GetColor(curStage);
		return false;
	}

	private int GetStage(int count)
	{
		int result = 0;
		for (int i = 0; i < count2Color.Length && count >= count2Color[i].startCount; i++)
		{
			result = i;
		}
		return result;
	}

	private void SetDmg(int dmg)
	{
		dmgNumber.text = dmg.FastToString();
	}
}
