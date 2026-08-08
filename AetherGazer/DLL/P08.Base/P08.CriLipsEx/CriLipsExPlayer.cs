using System;
using UnityEngine;

namespace P08.CriLipsEx;

public class CriLipsExPlayer : MonoBehaviour
{
	public int A = 16;

	[NonSerialized]
	[HideInInspector]
	public int I = -1;

	public int U = 18;

	public int E = 17;

	public int O = 19;

	public SkinnedMeshRenderer m_skinnedMeshRenderer;

	private CriAtomExPlayback _criAtomExPlayback;

	private float _criAtomExPlayTime;

	private bool _runtime;

	private bool _hasVoice;

	private CriLipsExCueData _criLipsExCueData;

	public void ResetData()
	{
		A = -1;
		I = -1;
		U = -1;
		E = -1;
		O = -1;
	}

	public void Play(string pSheetName, string pCueName, CriAtomExPlayback pCriAtomExPlayback)
	{
		_criLipsExCueData = CriLipsExAtom.GetCueSheet(pSheetName, pCueName);
		if (_criLipsExCueData != null)
		{
			_criAtomExPlayback = pCriAtomExPlayback;
			_criAtomExPlayTime = 0f;
			_runtime = true;
			_hasVoice = false;
		}
	}

	private void LateUpdate()
	{
		if (!_runtime)
		{
			return;
		}
		long time = _criAtomExPlayback.GetTime();
		if (time >= 0)
		{
			int num = (int)(time / 33);
			if (_criLipsExCueData.m_criLipsExFrameDatas.Length <= num)
			{
				_runtime = false;
				SetBlendShapeWeight(0f, 0f, 0f, 0f, 0f);
			}
			else
			{
				CriLipsExFrameData criLipsExFrameData = _criLipsExCueData.m_criLipsExFrameDatas[num];
				SetBlendShapeWeight((float)(int)criLipsExFrameData.m_a / 10f, (float)(int)criLipsExFrameData.m_i / 10f, (float)(int)criLipsExFrameData.m_u / 10f, (float)(int)criLipsExFrameData.m_e / 10f, (float)(int)criLipsExFrameData.m_o / 10f);
				_hasVoice = true;
			}
		}
		else if (_hasVoice)
		{
			_runtime = false;
			SetBlendShapeWeight(0f, 0f, 0f, 0f, 0f);
		}
		else
		{
			int num2 = (int)(_criAtomExPlayTime / 33f);
			if (_criLipsExCueData.m_criLipsExFrameDatas.Length <= num2)
			{
				_runtime = false;
				SetBlendShapeWeight(0f, 0f, 0f, 0f, 0f);
			}
			else
			{
				CriLipsExFrameData criLipsExFrameData2 = _criLipsExCueData.m_criLipsExFrameDatas[num2];
				SetBlendShapeWeight((float)(int)criLipsExFrameData2.m_a / 10f, (float)(int)criLipsExFrameData2.m_i / 10f, (float)(int)criLipsExFrameData2.m_u / 10f, (float)(int)criLipsExFrameData2.m_e / 10f, (float)(int)criLipsExFrameData2.m_o / 10f);
				_criAtomExPlayTime += Time.deltaTime * 1000f;
			}
		}
	}

	public void SetBlendShapeWeight(float pA, float pI, float pU, float pE, float pO)
	{
		if (A != -1)
		{
			m_skinnedMeshRenderer.SetBlendShapeWeight(A, pA);
		}
		if (I != -1)
		{
			m_skinnedMeshRenderer.SetBlendShapeWeight(I, pI);
		}
		if (U != -1)
		{
			m_skinnedMeshRenderer.SetBlendShapeWeight(U, pU);
		}
		if (E != -1)
		{
			m_skinnedMeshRenderer.SetBlendShapeWeight(E, pE);
		}
		if (O != -1)
		{
			m_skinnedMeshRenderer.SetBlendShapeWeight(O, pO);
		}
	}

	public void Stop()
	{
		_runtime = false;
	}
}
