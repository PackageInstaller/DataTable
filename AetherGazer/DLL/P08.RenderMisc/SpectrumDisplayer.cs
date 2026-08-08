using UnityEngine;
using UnityEngine.UI;

[ExecuteInEditMode]
[RequireComponent(typeof(Image))]
public class SpectrumDisplayer : MonoBehaviour
{
	public enum DistributionForAxis
	{
		Default,
		Linear,
		Custom,
		ThirdPartyApp
	}

	public enum DownSampleType
	{
		Average = 0,
		MaxDiff = 2,
		Default = 3
	}

	private readonly int m_NoiseTex = Shader.PropertyToID("_NoiseTex");

	[SerializeField]
	public DistributionForAxis _distributionForAxisX = DistributionForAxis.Linear;

	[SerializeField]
	public DistributionForAxis _distributionForAxisY = DistributionForAxis.Custom;

	[SerializeField]
	public DownSampleType _downSampleType;

	[SerializeField]
	public float _gaussianRadius = 1f;

	[SerializeField]
	[Range(1f, 20f)]
	public int _gaussianSample = 1;

	[SerializeField]
	public bool _useAutoMinMax;

	[SerializeField]
	public float _valueAdjustForY = 1f;

	[SerializeField]
	public float _valueAdjustForX = 1f;

	[SerializeField]
	[Range(0f, 1f)]
	public float _minValueForX;

	[SerializeField]
	[Range(0f, 1f)]
	public float _maxValueForX = 1f;

	[SerializeField]
	public float _minDecibel;

	[SerializeField]
	public float _maxDecibel = 5f;

	[SerializeField]
	[Range(0f, 0.5f)]
	public float _delayTimeToUpdate = 0.25f;

	[SerializeField]
	[Range(1f, 512f)]
	private int _texSize = 256;

	[SerializeField]
	public bool _texIsLinear = true;

	private const int maxTexSize = 512;

	private const int defaultTexSize = 512;

	private Texture2D _outputTex;

	private Image m_Image;

	private Material m_material;

	private float[] _prevOutputData = new float[512];

	private float[] _outputData = new float[512];

	private float[] _validInputData;

	private float[] _inputData;

	private float delayTime;

	public int texSize
	{
		get
		{
			return _texSize;
		}
		set
		{
			resetOutputDataSize(_texSize = ((inputData == null) ? intClamp(value, 0, 512) : intClamp(value, 0, inputData.Length)));
		}
	}

	private Texture2D outputTex
	{
		get
		{
			if (_outputTex == null)
			{
				generateNewTex(texSize);
			}
			return _outputTex;
		}
		set
		{
			_outputTex = value;
		}
	}

	private Image img
	{
		get
		{
			if (m_Image == null)
			{
				m_Image = GetComponent<Image>();
			}
			return m_Image;
		}
	}

	private Material mat
	{
		get
		{
			if (m_material == null)
			{
				img.material = Object.Instantiate(img.material);
				m_material = img.material;
			}
			return m_material;
		}
	}

	public float[] inputData
	{
		get
		{
			return _inputData;
		}
		set
		{
			if (value != null)
			{
				float[] iLinearLvs = clampInputData(ref value, _minValueForX, _maxValueForX);
				if (_texSize > iLinearLvs.Length)
				{
					_texSize = iLinearLvs.Length;
					resetOutputDataSize(_texSize);
				}
				if (delayTime <= 0f)
				{
					delayTime = _delayTimeToUpdate;
					_outputData.CopyTo(_prevOutputData, 0);
					Linear2Log(ref iLinearLvs, ref _prevOutputData, ref _outputData);
					_inputData = iLinearLvs;
				}
				if (_delayTimeToUpdate <= 0f)
				{
					outputTex.SetPixels(lerpBetweenTwoFloatArray(ref _prevOutputData, ref _outputData, 0f));
					outputTex.Apply();
				}
			}
		}
	}

	private int intClamp(int intput, int left, int right)
	{
		if (intput >= left)
		{
			if (intput <= right)
			{
				return intput;
			}
			return right;
		}
		return left;
	}

	private void generateNewTex(int size)
	{
		_outputTex = new Texture2D(size, 1, TextureFormat.RGB24, mipChain: false, linear: true);
		_outputTex.wrapMode = TextureWrapMode.Clamp;
		_outputTex.filterMode = FilterMode.Point;
	}

	private void Start()
	{
		resetOutputDataSize(_texSize);
	}

	private void resetOutputDataSize(int size)
	{
		if (size <= 0)
		{
			_outputData.CopyTo(_prevOutputData, 0);
			_outputData = new float[0];
		}
		else if (_outputData == null || _outputData.Length != size)
		{
			float[] array = new float[size];
			int num = ((_outputData != null) ? _outputData.Length : 0);
			int num2 = ((size > num) ? num : size);
			for (int i = 0; i < num2; i++)
			{
				float num3 = ((_outputData == null) ? 0f : _outputData[i]);
				array[i] = num3;
			}
			_outputData.CopyTo(_prevOutputData, 0);
			_outputData = array;
			if (_outputTex != null)
			{
				Object.Destroy(_outputTex);
			}
			generateNewTex(size);
		}
	}

	private void OnDestroy()
	{
		if (_outputTex != null)
		{
			Object.Destroy(_outputTex);
		}
		if (m_material != null)
		{
			Object.Destroy(m_material);
		}
	}

	private float[] clampInputData(ref float[] input_1, float minIndex, float maxIndex)
	{
		int num = input_1.Length - 1;
		int intput = Mathf.FloorToInt((float)num * minIndex);
		int intput2 = Mathf.CeilToInt((float)num * maxIndex);
		intput = intClamp(intput, 0, num);
		intput2 = intClamp(intput2, 0, num);
		float[] array = new float[intput2 - intput + 1];
		int num2 = 0;
		for (int i = intput; i <= intput2; i++)
		{
			array[num2] = input_1[i];
			num2++;
		}
		return array;
	}

	private Color[] lerpBetweenTwoFloatArray(ref float[] input_1, ref float[] input_2, float lerpFactor)
	{
		Color[] array = new Color[input_2.Length];
		for (int i = 0; i < array.Length; i++)
		{
			float num = input_1[i] * lerpFactor + input_2[i] * (1f - lerpFactor);
			array[i] = new Color(num, num, num, num);
			if (!_texIsLinear)
			{
				array[i] = array[i].gamma;
			}
		}
		return array;
	}

	private float gaussianFactor(float x, float sigma)
	{
		float num = 0.3989423f / sigma;
		float num2 = Mathf.Exp((0f - x) * x / 2f / sigma / sigma);
		return num * num2;
	}

	private int getIndexOfMaxValue(int inputIndex, float inputValue, int currentIndexOfMaxValue, ref float currentMaxValue)
	{
		if (inputValue >= currentMaxValue)
		{
			currentMaxValue = inputValue;
			return inputIndex;
		}
		return currentIndexOfMaxValue;
	}

	private float calculateArea(ref float[] prevOutputArray, ref float[] outputArray, ref float[] inputArray, float left, float right, int outputArrayIndex)
	{
		left = Mathf.Max(left, 0f);
		right = Mathf.Min(right, inputArray.Length - 1);
		float num = 0f;
		if (_downSampleType == DownSampleType.Average)
		{
			for (float num2 = left; num2 < right; num2 = Mathf.Floor(num2 + 1f))
			{
				int intput = Mathf.FloorToInt(num2);
				intput = intClamp(intput, 0, inputArray.Length - 1);
				float num3 = inputArray[intput];
				float num4 = Mathf.Min(right, Mathf.Floor(num2 + 1f));
				float num5 = num2;
				num += (num4 - num5) * num3;
			}
			return num / (right - left);
		}
		if (_downSampleType == DownSampleType.Default)
		{
			int intput2 = Mathf.FloorToInt(left) - 1;
			int intput3 = Mathf.FloorToInt(right) - 1;
			intput2 = intClamp(intput2, 0, inputArray.Length - 1);
			intput3 = intClamp(intput3, 0, inputArray.Length - 1);
			float num6 = 0f;
			for (int i = intput2; i <= intput3; i++)
			{
				num6 += inputArray[i];
			}
			return num6 / (float)(intput3 - intput2 + 1);
		}
		if (prevOutputArray == null || prevOutputArray.Length == 0)
		{
			return getFloatIndexFormArry(ref inputArray, (left + right) / 2f);
		}
		if (prevOutputArray.Length != outputArray.Length)
		{
			return getFloatIndexFormArry(ref inputArray, (left + right) / 2f);
		}
		int num7 = Mathf.CeilToInt(left);
		int num8 = Mathf.FloorToInt(right);
		float currentMaxValue = -1f;
		int num9 = outputArrayIndex;
		float num10 = prevOutputArray[outputArrayIndex];
		for (int j = num7; j < num8; j++)
		{
			float inputValue = Mathf.Abs(inputArray[j] - num10);
			num9 = getIndexOfMaxValue(j, inputValue, num9, ref currentMaxValue);
		}
		float floatIndexFormArry = getFloatIndexFormArry(ref inputArray, left);
		float num11 = Mathf.Abs(floatIndexFormArry - num10);
		float floatIndexFormArry2 = getFloatIndexFormArry(ref inputArray, right);
		float num12 = Mathf.Abs(floatIndexFormArry2 - num10);
		if (num11 >= num12)
		{
			if (num11 >= currentMaxValue)
			{
				return floatIndexFormArry;
			}
			return inputArray[num9];
		}
		if (num12 >= currentMaxValue)
		{
			return floatIndexFormArry2;
		}
		return inputArray[num9];
	}

	private float getFloatIndexFormArry(ref float[] inputArray, float index)
	{
		int intput = Mathf.FloorToInt(index);
		int intput2 = Mathf.CeilToInt(index);
		intput = intClamp(intput, 0, inputArray.Length - 1);
		intput2 = intClamp(intput2, 0, inputArray.Length - 1);
		float t = index - (float)intput;
		return Mathf.Lerp(inputArray[intput], inputArray[intput2], t);
	}

	private float curveFromThirdPartyApp(float input)
	{
		float num = input * input;
		float num2 = num * input;
		return 0.002283392f * num2 + 0.22436795f * num + 2.977579f * input + 47.172894f;
	}

	private bool Linear2Log(ref float[] iLinearLvs, ref float[] oLogLvsPrev, ref float[] oLogLvs)
	{
		if (iLinearLvs == null || oLogLvs == null)
		{
			return false;
		}
		int num = iLinearLvs.Length;
		int num2 = oLogLvs.Length;
		float num3 = 0f;
		float num4 = 65535f;
		for (int i = 0; i < num2; i++)
		{
			float num5;
			float num6;
			if (_distributionForAxisX == DistributionForAxis.Default)
			{
				num5 = Mathf.Pow(num, (float)i / (float)num2);
				num6 = Mathf.Pow(num, (float)(i + 1) / (float)num2);
				num5--;
				num6--;
			}
			else if (_distributionForAxisX == DistributionForAxis.Linear)
			{
				num5 = (float)num * (float)i / (float)num2;
				num6 = (float)num * (float)(i + 1) / (float)num2;
			}
			else if (_distributionForAxisX == DistributionForAxis.ThirdPartyApp)
			{
				float num7 = 44100f / 2f;
				num7 *= _valueAdjustForX;
				float num8 = 48f;
				num5 = curveFromThirdPartyApp((float)i / (float)num2 * num8);
				num6 = curveFromThirdPartyApp((float)(i + 1) / (float)num2 * num8);
				num5 = Mathf.Clamp01(num5 / num7) * (float)num;
				num6 = Mathf.Clamp01(num6 / num7) * (float)num;
			}
			else
			{
				float f = (float)i / (float)num2;
				float f2 = (float)(i + 1) / (float)num2;
				f = Mathf.Pow(f, _valueAdjustForX);
				f2 = Mathf.Pow(f2, _valueAdjustForX);
				num5 = (float)num * f;
				num6 = (float)num * f2;
			}
			float num9 = calculateArea(ref oLogLvsPrev, ref oLogLvs, ref iLinearLvs, num5, num6, i);
			if (_distributionForAxisY == DistributionForAxis.Default)
			{
				num9 = Mathf.Log10(num9) * 20f;
				num9 = (num9 + 60f) / 20f / _maxDecibel;
				if (num9 < 0f || float.IsNaN(num9) || float.IsInfinity(num9))
				{
					num9 = 0f;
				}
			}
			else if (_distributionForAxisY == DistributionForAxis.Linear)
			{
				num9 /= _maxDecibel;
			}
			else if (_distributionForAxisY == DistributionForAxis.ThirdPartyApp)
			{
				num9 = Mathf.Log10(num9 / _maxDecibel) * 20f;
				num9 = Mathf.Clamp(num9, 0f - _minDecibel, 0f);
				num9 += _minDecibel;
				num9 /= _minDecibel;
				if (num9 < 0f || float.IsNaN(num9) || float.IsInfinity(num9))
				{
					num9 = 0f;
				}
				num3 = Mathf.Max(num3, num9);
				num4 = Mathf.Min(num4, num9);
			}
			else
			{
				num9 = Mathf.Log10(num9) * 20f;
				if (num9 < -60f || float.IsNaN(num9) || float.IsInfinity(num9))
				{
					num9 = 0f;
				}
				if (!_useAutoMinMax)
				{
					num9 = Mathf.Pow(num9, _valueAdjustForY);
					num9 = (Mathf.Clamp(num9, _minDecibel, _maxDecibel) - _minDecibel) / (_maxDecibel - _minDecibel);
				}
			}
			num3 = Mathf.Max(num3, num9);
			num4 = Mathf.Min(num4, num9);
			oLogLvs[i] = num9;
		}
		if (_useAutoMinMax)
		{
			for (int i = 0; i < num2; i++)
			{
				if (num3 - num4 <= 0f)
				{
					oLogLvs[i] = 0f;
					continue;
				}
				oLogLvs[i] = (oLogLvs[i] - num4) / (num3 - num4);
				if (_distributionForAxisY == DistributionForAxis.Custom)
				{
					float num10 = _minDecibel / 15f;
					float num11 = _maxDecibel / 15f;
					oLogLvs[i] = (Mathf.Clamp(oLogLvs[i], num10, num11) - num10) / Mathf.Max(0.001f, num11 - num10);
					oLogLvs[i] = Mathf.Pow(oLogLvs[i], _valueAdjustForY);
				}
			}
		}
		return true;
	}

	public void MyUpdate()
	{
		delayTime -= Time.deltaTime;
		if (_delayTimeToUpdate > 0f)
		{
			outputTex.SetPixels(lerpBetweenTwoFloatArray(ref _prevOutputData, ref _outputData, Mathf.Clamp01(delayTime / Mathf.Max(_delayTimeToUpdate, 0.001f))));
			outputTex.Apply();
		}
		if (mat != null)
		{
			mat.SetTexture(m_NoiseTex, outputTex);
		}
	}

	private void Update()
	{
		MyUpdate();
	}
}
