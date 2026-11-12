using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class ActorElementInfo : LogicComponent
{
	private AttributeList attributeList;

	[Space]
	public readonly List<int> hitElementTypeExtension = new List<int>();

	public HotfixEnum.elementType originElementType { get; set; }

	public HotfixEnum.elementType elementType { get; set; }

	public HashSet<HotfixEnum.elementType> weakElementType { get; } = new HashSet<HotfixEnum.elementType>(6);

	public FDP WEE => GetAttributeValue(HotfixEnum.effectAttributeType.WEE);

	public FDP FEE => GetAttributeValue(HotfixEnum.effectAttributeType.FEE);

	public FDP SEE => GetAttributeValue(HotfixEnum.effectAttributeType.SEE);

	public FDP AEE => GetAttributeValue(HotfixEnum.effectAttributeType.AEE);

	public FDP LEE => GetAttributeValue(HotfixEnum.effectAttributeType.LEE);

	public FDP DEE => GetAttributeValue(HotfixEnum.effectAttributeType.DEE);

	public FDP WEI => GetAttributeValue(HotfixEnum.effectAttributeType.WEI);

	public FDP FEI => GetAttributeValue(HotfixEnum.effectAttributeType.FEI);

	public FDP SEI => GetAttributeValue(HotfixEnum.effectAttributeType.SEI);

	public FDP AEI => GetAttributeValue(HotfixEnum.effectAttributeType.AEI);

	public FDP LEI => GetAttributeValue(HotfixEnum.effectAttributeType.LEI);

	public FDP DEI => GetAttributeValue(HotfixEnum.effectAttributeType.DEI);

	public FDP WEP => GetAttributeValue(HotfixEnum.effectAttributeType.WEP);

	public FDP FEP => GetAttributeValue(HotfixEnum.effectAttributeType.FEP);

	public FDP AEP => GetAttributeValue(HotfixEnum.effectAttributeType.AEP);

	public FDP SEP => GetAttributeValue(HotfixEnum.effectAttributeType.SEP);

	public FDP LEP => GetAttributeValue(HotfixEnum.effectAttributeType.LEP);

	public FDP DEP => GetAttributeValue(HotfixEnum.effectAttributeType.DEP);

	public FDP WER => GetAttributeValue(HotfixEnum.effectAttributeType.WER);

	public FDP FER => GetAttributeValue(HotfixEnum.effectAttributeType.FER);

	public FDP AER => GetAttributeValue(HotfixEnum.effectAttributeType.AER);

	public FDP SER => GetAttributeValue(HotfixEnum.effectAttributeType.SER);

	public FDP LER => GetAttributeValue(HotfixEnum.effectAttributeType.LER);

	public FDP DER => GetAttributeValue(HotfixEnum.effectAttributeType.DER);

	public FDP WEERCDRatio => GetAttributeValue(HotfixEnum.effectAttributeType.WEERCD);

	public FDP FEERCDRatio => GetAttributeValue(HotfixEnum.effectAttributeType.FEERCD);

	public FDP SEERCDRatio => GetAttributeValue(HotfixEnum.effectAttributeType.SEERCD);

	public FDP AEERCDRatio => GetAttributeValue(HotfixEnum.effectAttributeType.AEERCD);

	public FDP LEERCDRatio => GetAttributeValue(HotfixEnum.effectAttributeType.LEERCD);

	public FDP DEERCDRatio => GetAttributeValue(HotfixEnum.effectAttributeType.DEERCD);

	protected override void OnInit()
	{
		AdventureActor adventureActor = Entity as AdventureActor;
		if (adventureActor != null)
		{
			attributeList = adventureActor.attributeList;
		}
	}

	private FDP GetAttributeValue(HotfixEnum.effectAttributeType type)
	{
		if (attributeList == null || type == HotfixEnum.effectAttributeType.NONE || type == HotfixEnum.effectAttributeType.MAX)
		{
			return FDP.Zero;
		}
		return attributeList.GetAttributeValue(type);
	}

	private void SetOriginIntValue(HotfixEnum.effectAttributeType type, int val, FDP ratio)
	{
		attributeList?.SetOriginIntValue(type, val, ratio);
	}

	private void SetOriginIntValueAdjust(HotfixEnum.effectAttributeType type, int val, FDP ratio, int adjustRatio, int adjustFix)
	{
		attributeList?.SetOriginIntValueAdjust(type, val, ratio, adjustRatio, adjustFix);
	}

	private void SetOriginIntFloatValue(HotfixEnum.effectAttributeType type, int val, FDP ratio)
	{
		attributeList?.SetOriginIntFloatValue(type, val, ratio);
	}

	public void SetOriginAttributeData(Attribute attributeConfig, FDP ratio)
	{
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.WEE, attributeConfig.WEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.FEE, attributeConfig.FEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SEE, attributeConfig.SEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.AEE, attributeConfig.AEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.LEE, attributeConfig.LEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.DEE, attributeConfig.DEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.WEI, attributeConfig.WEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.FEI, attributeConfig.FEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SEI, attributeConfig.SEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.AEI, attributeConfig.AEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.LEI, attributeConfig.LEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.DEI, attributeConfig.DEI, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.WER, attributeConfig.WER, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.FER, attributeConfig.FER, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.SER, attributeConfig.SER, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.AER, attributeConfig.AER, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.LER, attributeConfig.LER, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.DER, attributeConfig.DER, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.WEP, attributeConfig.WEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.FEP, attributeConfig.FEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.SEP, attributeConfig.SEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.AEP, attributeConfig.AEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.LEP, attributeConfig.LEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.DEP, attributeConfig.DEP, ratio);
	}

	public void SetOriginAttributeData(MonsterValueTemplete attributeConfig, MonsterValueTempleteAdjust templeteAdjustInfo, FDP ratio)
	{
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.WEE, attributeConfig.WEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.FEE, attributeConfig.FEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SEE, attributeConfig.SEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.AEE, attributeConfig.AEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.LEE, attributeConfig.LEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.DEE, attributeConfig.DEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.WEI, attributeConfig.WEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.FEI, attributeConfig.FEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SEI, attributeConfig.SEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.AEI, attributeConfig.AEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.LEI, attributeConfig.LEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.DEI, attributeConfig.DEI, ratio);
		if (templeteAdjustInfo != null)
		{
			SetOriginIntValueAdjust(HotfixEnum.effectAttributeType.WER, attributeConfig.WER, ratio, templeteAdjustInfo.WERRatio, templeteAdjustInfo.WERFix);
			SetOriginIntValueAdjust(HotfixEnum.effectAttributeType.FER, attributeConfig.FER, ratio, templeteAdjustInfo.FERRatio, templeteAdjustInfo.FERFix);
			SetOriginIntValueAdjust(HotfixEnum.effectAttributeType.SER, attributeConfig.SER, ratio, templeteAdjustInfo.SERRatio, templeteAdjustInfo.SERFix);
			SetOriginIntValueAdjust(HotfixEnum.effectAttributeType.AER, attributeConfig.AER, ratio, templeteAdjustInfo.AERRatio, templeteAdjustInfo.AERFix);
			SetOriginIntValueAdjust(HotfixEnum.effectAttributeType.LER, attributeConfig.LER, ratio, templeteAdjustInfo.LERRatio, templeteAdjustInfo.LERFix);
			SetOriginIntValueAdjust(HotfixEnum.effectAttributeType.DER, attributeConfig.DER, ratio, templeteAdjustInfo.DERRatio, templeteAdjustInfo.DERFix);
		}
		else
		{
			SetOriginIntValue(HotfixEnum.effectAttributeType.WER, attributeConfig.WER, ratio);
			SetOriginIntValue(HotfixEnum.effectAttributeType.FER, attributeConfig.FER, ratio);
			SetOriginIntValue(HotfixEnum.effectAttributeType.SER, attributeConfig.SER, ratio);
			SetOriginIntValue(HotfixEnum.effectAttributeType.AER, attributeConfig.AER, ratio);
			SetOriginIntValue(HotfixEnum.effectAttributeType.LER, attributeConfig.LER, ratio);
			SetOriginIntValue(HotfixEnum.effectAttributeType.DER, attributeConfig.DER, ratio);
		}
		SetOriginIntValue(HotfixEnum.effectAttributeType.WEP, attributeConfig.WEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.FEP, attributeConfig.FEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.SEP, attributeConfig.SEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.AEP, attributeConfig.AEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.LEP, attributeConfig.LEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.DEP, attributeConfig.DEP, ratio);
	}

	public void SetOriginAttributeData(Lua2CSharpInfo_CharAttribute attributeConfig, FDP ratio)
	{
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.WEE, attributeConfig.WEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.FEE, attributeConfig.FEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SEE, attributeConfig.SEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.AEE, attributeConfig.AEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.LEE, attributeConfig.LEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.DEE, attributeConfig.DEE, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.WEI, attributeConfig.WEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.FEI, attributeConfig.FEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SEI, attributeConfig.SEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.AEI, attributeConfig.AEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.LEI, attributeConfig.LEI, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.DEI, attributeConfig.DEI, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.WER, attributeConfig.WER, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.FER, attributeConfig.FER, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.SER, attributeConfig.SER, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.AER, attributeConfig.AER, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.LER, attributeConfig.LER, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.DER, attributeConfig.DER, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.WEP, attributeConfig.WEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.FEP, attributeConfig.FEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.SEP, attributeConfig.SEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.AEP, attributeConfig.AEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.LEP, attributeConfig.LEP, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.DEP, attributeConfig.DEP, ratio);
	}
}
