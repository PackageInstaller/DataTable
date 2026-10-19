using ACT.Core;
using ACT.MultiPlayer;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class DamageNumberGeneral : DamageNumberStyle
{
	public bool enableWeakEffect;

	[SerializeField]
	private DamageNumberWeakEffect weakEffect;

	public bool enableCritical;

	[SerializeField]
	private RectTransform criticalIconRoot;

	[SerializeField]
	private Image criticalIcon1;

	[SerializeField]
	private Image criticalIcon2;

	[SerializeField]
	private DamageNumberCriticalEffect criticalEffect;

	public bool enableDot;

	[SerializeField]
	private GameObject dotIconRootObj;

	[SerializeField]
	private RectTransform dotIconRoot;

	[SerializeField]
	private float dotIconRootOffset = 20f;

	public Image dotIcon;

	public bool enableManner;

	[SerializeField]
	private GameObject mannerIconRootObj;

	[SerializeField]
	private RectTransform mannerIconRoot;

	[SerializeField]
	private float mannerIconRootOffsetWithDot = 40f;

	[SerializeField]
	private float mannerIconRootOffset = 20f;

	public Image mannerIcon;

	public override void Init(CmdDamageNumber cmd, DamageNumberConfig config)
	{
		base.Init(cmd, config);
		switch (cmd.damageFeature)
		{
		case DamageFeature.Damage:
		case DamageFeature.Dot:
		case DamageFeature.Manner:
			ApplyDamageNumber(cmd, config);
			ApplyWeak(cmd, config);
			ApplyCritical(cmd, config);
			ApplyDot(cmd, config);
			ApplyManner(cmd, config);
			break;
		case DamageFeature.Heal:
			ApplyDamageNum(_config.healNumSprites, setColor: true, _config.healNumColor);
			break;
		case DamageFeature.HpRemoval:
		case DamageFeature.Sacrifice:
			ApplyDamageNum(_config.sacrificeSprites, setColor: true, _config.sacrificeColor);
			break;
		case DamageFeature.Sprint:
		case DamageFeature.Resistance:
		case DamageFeature.Block:
			break;
		}
	}

	private void ApplyDamageNumber(CmdDamageNumber cmd, DamageNumberConfig config)
	{
		Sprite[] source;
		if (cmd.IsSacrifice)
		{
			source = config.sacrificeSprites;
		}
		else
		{
			source = (cmd.IsCharacter ? config.GetNumSprites(Element.Dark) : config.GetNumSprites(cmd.element));
		}
		ApplyDamageNum(source);
	}

	private void ApplyWeak(CmdDamageNumber cmd, DamageNumberConfig config)
	{
		if (enableWeakEffect)
		{
			weakEffect.gameObject.SetActive(cmd.isWeakElement);
			if (cmd.isWeakElement)
			{
				int damageNumDigits = GetDamageNumDigits(_damage, numImages.Length);
				float num = numImages[0].transform.position.x + numImages[damageNumDigits - 1].transform.position.x;
				weakEffect.transform.position = new Vector3(num * 0.5f, weakEffect.transform.position.y, weakEffect.transform.position.z);
				weakEffect.Init(config.GetWeakColor(cmd.element));
				weakEffect.SetWidth(damageNumDigits);
			}
		}
	}

	private void ApplyCritical(CmdDamageNumber cmd, DamageNumberConfig config)
	{
		if (enableCritical)
		{
			SetToCenter(criticalEffect.transform);
			criticalEffect.Init(config.GetCriticalGlowColor(cmd.element));
			int damageNumDigits = GetDamageNumDigits(_damage, numImages.Length);
			criticalIconRoot.anchoredPosition = new Vector2(numImages[damageNumDigits - 1].rectTransform.anchoredPosition.x + 40f, criticalIconRoot.anchoredPosition.y);
			(Sprite, Sprite) criticalIcon = config.GetCriticalIcon(cmd.element);
			criticalIcon1.sprite = criticalIcon.Item1;
			criticalIcon2.sprite = criticalIcon.Item2;
		}
	}

	private void ApplyDot(CmdDamageNumber cmd, DamageNumberConfig config)
	{
		if (cmd.dotIconId == -1 || cmd.damageFeature != DamageFeature.Dot)
		{
			dotIcon.sprite = null;
			dotIconRootObj.SetActive(value: false);
		}
		else
		{
			dotIconRootObj.SetActive(value: true);
			dotIcon.sprite = config.GetDotIcon(cmd.element, cmd.dotIconId);
			dotIconRoot.anchoredPosition = new Vector2(numImages[0].rectTransform.anchoredPosition.x - dotIconRootOffset, dotIconRoot.anchoredPosition.y);
		}
	}

	private void ApplyManner(CmdDamageNumber cmd, DamageNumberConfig config)
	{
		mannerIcon.sprite = config.GetMannerIcon(cmd.element, cmd.mannerType);
		mannerIconRootObj.SetActive(mannerIcon.sprite != null);
		if (dotIconRootObj.activeSelf)
		{
			mannerIconRoot.anchoredPosition = new Vector2(numImages[0].rectTransform.anchoredPosition.x - mannerIconRootOffsetWithDot, mannerIconRoot.anchoredPosition.y);
		}
		else
		{
			mannerIconRoot.anchoredPosition = new Vector2(numImages[0].rectTransform.anchoredPosition.x - mannerIconRootOffset, mannerIconRoot.anchoredPosition.y);
		}
	}
}
