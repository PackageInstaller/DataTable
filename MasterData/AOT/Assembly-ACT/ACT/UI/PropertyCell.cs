using System;
using System.Globalization;
using ACT.Config;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class PropertyCell : BaseUIComponent
{
	[Header("文字图片")]
	public BImage icon;

	public GameObject propertyRoot;

	public LocalizeStringEvent title;

	public TextMeshProUGUI propertyNum1;

	public TextMeshProUGUI propertyNum2;

	[Header("属性图片")]
	public BImage ImagePropertyIcon;

	public TextMeshProUGUI propertyNum;

	public TextMeshProUGUI propertyNameText;

	public LocalizeStringEvent propertyName;

	public Image arrowImage;

	[Header("单一描述")]
	public LocalizeStringEvent singleString;

	[Header("动画")]
	public Animation animation;

	public Transform effectRoot;

	public BetterAnimation anim;

	[Header("底板")]
	public Image board;

	[NonSerialized]
	public object context;

	public void SetEffectRoot(Transform Go)
	{
		anim.GetSequence("LevelUp").Play();
		if (Go != null)
		{
			Go.SetParent(effectRoot, worldPositionStays: false);
		}
	}

	public void InitInNum(int localizeId, string num1 = "", string num2 = "", bool isAdd = false)
	{
		propertyName.StringReference.TableEntryReference = localizeId;
		if (!string.IsNullOrEmpty(num1))
		{
			propertyNum1.gameObject.SetActive(value: true);
			propertyNum1.text = num1.ToString(CultureInfo.InvariantCulture);
		}
		else
		{
			propertyNum1.gameObject.SetActive(value: false);
		}
		if (!(propertyNum2 != null))
		{
			return;
		}
		if (!string.IsNullOrEmpty(num2))
		{
			propertyNum2.gameObject.SetActive(value: true);
			if (isAdd)
			{
				propertyNum2.text = "+" + num2.ToString();
			}
			else
			{
				propertyNum2.text = num2;
			}
		}
		else
		{
			propertyNum2.gameObject.SetActive(value: false);
		}
	}

	public void InitInNumNeedIcon(PropertyData data, int localizeId, ImageAssetStation station = null, string num1 = "", string num2 = "", bool isAdd = false)
	{
		station?.LoadImage(146, data.icon, ImagePropertyIcon);
		InitInNum(localizeId, num1, num2, isAdd);
	}

	public void InitInNum(int titleId, int localizeId, string num1 = "", string num2 = "", bool isAdd = false)
	{
		title.StringReference.TableEntryReference = titleId;
		propertyName.StringReference.TableEntryReference = localizeId;
		if (!string.IsNullOrEmpty(num1))
		{
			propertyNum1.gameObject.SetActive(value: true);
			if ((bool)singleString)
			{
				singleString.gameObject.SetActive(value: false);
			}
			propertyNum1.text = num1.ToString(CultureInfo.InvariantCulture);
			if (!string.IsNullOrEmpty(num2))
			{
				propertyNum2.gameObject.SetActive(value: true);
				if (isAdd)
				{
					propertyNum2.text = "+" + num2.ToString();
				}
				else
				{
					propertyNum2.text = num2;
				}
			}
			else
			{
				propertyNum2.gameObject.SetActive(value: false);
			}
		}
		else
		{
			if ((bool)singleString)
			{
				singleString.gameObject.SetActive(value: true);
				singleString.OnUpdateString.Invoke(num2);
			}
			propertyNum1.gameObject.SetActive(value: false);
		}
	}

	public void InitInString(string titleString, int contentId, string num1 = "", string num2 = "", bool isAdd = false)
	{
		title.OnUpdateString.Invoke(titleString);
		InitInString(contentId, num1, num2, isAdd);
	}

	public void InitInString(int contentId, string num1 = "", string num2 = "", bool isAdd = false)
	{
		propertyName.StringReference.TableEntryReference = contentId;
		if (!string.IsNullOrEmpty(num1))
		{
			if ((bool)singleString)
			{
				singleString.gameObject.SetActive(value: false);
			}
			propertyRoot.SetActive(value: true);
			propertyNum1.text = num1.ToString(CultureInfo.InvariantCulture);
			if (!string.IsNullOrEmpty(num2))
			{
				propertyNum2.gameObject.SetActive(value: true);
				if (isAdd)
				{
					propertyNum2.text = "+" + num2.ToString();
				}
				else
				{
					propertyNum2.text = num2;
				}
			}
			else
			{
				propertyNum2.gameObject.SetActive(value: false);
			}
		}
		else
		{
			if ((bool)singleString)
			{
				singleString.gameObject.SetActive(value: true);
				singleString.OnUpdateString.Invoke(num2);
			}
			propertyRoot.SetActive(value: false);
		}
	}

	public void ShowInit(PropertyData property1Data, float property1Value, PropertyData property2Data = null, float property2Value = float.NaN)
	{
		propertyName.StringReference.TableEntryReference = property1Data.descLocal;
		propertyNum1.gameObject.SetActive(value: true);
		if ((bool)propertyNum)
		{
			propertyNum.gameObject.SetActive(value: false);
		}
		if (property1Data.judge)
		{
			SetNum1Value(GameUtility.TopercentageMathfFloor(property1Value / 10000f, 1));
		}
		else
		{
			SetNum1Value(Mathf.FloorToInt(property1Value).ToString());
		}
		bool flag = property2Data != null && !float.IsNaN(property2Value);
		if ((bool)propertyNum2)
		{
			propertyNum2.gameObject.SetActive(flag);
		}
		if ((bool)arrowImage)
		{
			arrowImage.gameObject.SetActive(flag);
		}
		if (flag)
		{
			if (property2Data.judge)
			{
				SetNum2Value(GameUtility.TopercentageMathfFloor(property2Value / 10000f, 1));
			}
			else
			{
				SetNum2Value(Mathf.FloorToInt(property2Value).ToString());
			}
		}
	}

	public void ShowInitInNumNeedIcon(PropertyData property1Data, float property1Value, ImageAssetStation station = null, PropertyData property2Data = null, float property2Value = float.NaN)
	{
		if (station != null && ImagePropertyIcon != null)
		{
			station.LoadImage(146, property1Data.icon, ImagePropertyIcon);
		}
		ShowInit(property1Data, property1Value, property2Data, property2Value);
	}

	public void Init(PropertyData property2Data, float property2Value, PropertyData property1Data = null, float property1Value = float.NaN, ImageAssetStation station = null)
	{
		if (station != null && ImagePropertyIcon != null)
		{
			station.LoadImage(146, property2Data.icon, ImagePropertyIcon);
		}
		propertyName.StringReference.TableEntryReference = property2Data.descLocal;
		propertyNum2.gameObject.SetActive(value: true);
		if ((bool)propertyNum)
		{
			propertyNum.gameObject.SetActive(value: false);
		}
		if (property2Data.judge)
		{
			SetNum2Value(GameUtility.TopercentageMathfFloor(property2Value, 1));
		}
		else
		{
			SetNum2Value(Mathf.FloorToInt(property2Value).ToString());
		}
		bool flag = property1Data != null && !float.IsNaN(property1Value);
		if ((bool)propertyNum1)
		{
			propertyNum1.gameObject.SetActive(flag);
		}
		if (flag)
		{
			if (property1Data.judge)
			{
				SetNum1Value(GameUtility.TopercentageMathfFloor(property1Value, 1));
			}
			else
			{
				SetNum1Value(Mathf.FloorToInt(property1Value).ToString());
			}
		}
	}

	public void InitPropertyChange(PropertyData property2Data, float property2Value, PropertyData property1Data = null, float property1Value = float.NaN)
	{
		propertyName.StringReference.TableEntryReference = property2Data.descLocal;
		bool flag = property1Data != null && !float.IsNaN(property1Value);
		propertyNum.gameObject.SetActive(!flag);
		propertyNum1.gameObject.SetActive(flag);
		propertyNum2.gameObject.SetActive(flag);
		if (flag)
		{
			if (property2Data.judge)
			{
				SetNum2Value(GameUtility.TopercentageMathfFloor(property2Value, 1));
			}
			else
			{
				SetNum2Value(Mathf.FloorToInt(property2Value).ToString());
			}
			if (property1Data.judge)
			{
				SetNum1Value(GameUtility.TopercentageMathfFloor(property1Value, 1));
			}
			else
			{
				SetNum1Value(Mathf.FloorToInt(property1Value).ToString());
			}
		}
		else if (property2Data.judge)
		{
			SetNumValue(GameUtility.TopercentageMathfFloor(property2Value, 1));
		}
		else
		{
			SetNumValue(Mathf.FloorToInt(property2Value).ToString());
		}
	}

	public void InitSingle(int titleId, int localizeId, string content)
	{
		title.StringReference.TableEntryReference = titleId;
		propertyName.StringReference.TableEntryReference = localizeId;
		singleString.OnUpdateString.Invoke(content);
	}

	public void InitSkillPointGet(int fromSkillPoint, int toSkillPoint)
	{
		if ((bool)propertyNum)
		{
			propertyNum.gameObject.SetActive(value: false);
		}
		propertyNum1.gameObject.SetActive(value: true);
		propertyNum2.gameObject.SetActive(value: true);
		propertyName.StringReference.TableReference = LocalizationUtility.localizeTableName_Common;
		propertyName.StringReference.TableEntryReference = 1026L;
		SetNum1Value(fromSkillPoint.ToString());
		SetNum2Value(toSkillPoint.ToString());
	}

	public void SetNum1Value(string value)
	{
		if ((bool)propertyNum1)
		{
			propertyNum1.text = value;
		}
	}

	public void SetNum2Value(string value)
	{
		if ((bool)propertyNum2)
		{
			propertyNum2.text = value;
		}
	}

	public void SetNumValue(string value)
	{
		propertyNum.text = value;
	}

	public void SetDark()
	{
		Color color = propertyNum1.color;
		color.a = 0f;
		propertyNum1.color = color;
		color = propertyNum2.color;
		color.a = 0f;
		propertyNum2.color = color;
		color = propertyNameText.color;
		color.a = 0f;
		propertyNameText.color = color;
		color = arrowImage.color;
		color.a = 0f;
		arrowImage.color = color;
	}

	public void SetColor(Color color)
	{
		propertyNum2.color = color;
	}

	public void InitBoard(bool isShow)
	{
		board.gameObject.SetActive(isShow);
	}
}
