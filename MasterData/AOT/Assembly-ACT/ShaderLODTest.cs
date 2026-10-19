using UnityEngine;
using UnityEngine.Rendering;

public class ShaderLODTest : MonoBehaviour
{
	public enum QualityEnum
	{
		VERY_HIGH,
		HIGH,
		MEDIUM,
		LOW
	}

	public QualityEnum Quality = QualityEnum.HIGH;

	private GlobalKeyword lightQualityVeryHigh;

	private GlobalKeyword lightQualityHigh;

	private GlobalKeyword lightQualityMedium;

	private GlobalKeyword lightQualityLow;

	private GlobalKeyword GenericQualityVeryHigh;

	private GlobalKeyword GenericQualityHigh;

	private GlobalKeyword GenericQualityMedium;

	private GlobalKeyword GenericQualityLow;

	public void TestQuality()
	{
	}

	private void Awake()
	{
	}
}
