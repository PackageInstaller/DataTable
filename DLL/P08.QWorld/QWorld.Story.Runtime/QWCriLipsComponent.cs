using System;
using P08.CriLipsEx;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

namespace QWorld.Story.Runtime;

public class QWCriLipsComponent
{
	private SDCharacter character;

	private System.Random random;

	private const int Loop1_1 = 41;

	private const int Loop1_2 = 45;

	private const int Loop1_3 = 38;

	private const int Loop2_1 = 45;

	private const int Loop2_2 = 41;

	private const int Loop2_3 = 45;

	private const int Loop3_1 = 41;

	private const int Loop3_2 = 15;

	private const int Loop3_3 = 44;

	private const int Loop4_1 = 15;

	private const int Loop4_2 = 41;

	private const int Loop4_3 = 44;

	private bool isInLoop;

	private int curLoopSeria = 1;

	private int curLoopSeriaIdx = 1;

	public float speed = 0.07f;

	private float startTime;

	private CriAtomExPlayback _criAtomExPlayback;

	private bool _runtime;

	private CriLipsExCueData _criLipsExCueData;

	public QWCriLipsComponent(SDCharacter actor)
	{
		character = actor;
	}

	public void Play(string pSheetName, string pCueName, CriAtomExPlayback pCriAtomExPlayback)
	{
		isInLoop = false;
		curLoopSeria = 1;
		curLoopSeriaIdx = 1;
		if (random == null)
		{
			random = new System.Random(Time.frameCount);
		}
		_criLipsExCueData = CriLipsExAtom.GetCueSheet(pSheetName, pCueName);
		if (_criLipsExCueData != null)
		{
			_criAtomExPlayback = pCriAtomExPlayback;
			_runtime = true;
		}
	}

	public void LateTick()
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
			}
		}
		else
		{
			_runtime = false;
			character.sheetFaceId = 0;
			isInLoop = false;
			curLoopSeriaIdx = 1;
			curLoopSeria = 1;
		}
	}

	public void SetBlendShapeWeight(float pA, float pI, float pU, float pE, float pO)
	{
		if (Mathf.Max(pA, Mathf.Max(pE, Mathf.Max(pU, Mathf.Max(pO, pI)))) == 0f)
		{
			character.sheetFaceId = 41;
			isInLoop = false;
			curLoopSeriaIdx = 1;
			curLoopSeria = 1;
			return;
		}
		if (!isInLoop || curLoopSeriaIdx == 4)
		{
			curLoopSeria = random.Next(1, 4);
			curLoopSeriaIdx = 1;
			isInLoop = true;
		}
		if (isInLoop && Time.time - startTime < speed)
		{
			return;
		}
		startTime = Time.time;
		switch (curLoopSeria)
		{
		case 1:
			if (curLoopSeriaIdx == 1)
			{
				character.sheetFaceId = 41;
			}
			if (curLoopSeriaIdx == 2)
			{
				character.sheetFaceId = 45;
			}
			if (curLoopSeriaIdx == 3)
			{
				character.sheetFaceId = 38;
			}
			break;
		case 2:
			if (curLoopSeriaIdx == 1)
			{
				character.sheetFaceId = 45;
			}
			if (curLoopSeriaIdx == 2)
			{
				character.sheetFaceId = 41;
			}
			if (curLoopSeriaIdx == 3)
			{
				character.sheetFaceId = 45;
			}
			break;
		case 3:
			if (curLoopSeriaIdx == 1)
			{
				character.sheetFaceId = 41;
			}
			if (curLoopSeriaIdx == 2)
			{
				character.sheetFaceId = 15;
			}
			if (curLoopSeriaIdx == 3)
			{
				character.sheetFaceId = 44;
			}
			break;
		case 4:
			if (curLoopSeriaIdx == 1)
			{
				character.sheetFaceId = 15;
			}
			if (curLoopSeriaIdx == 2)
			{
				character.sheetFaceId = 41;
			}
			if (curLoopSeriaIdx == 3)
			{
				character.sheetFaceId = 44;
			}
			break;
		}
		curLoopSeriaIdx++;
	}

	public void Stop()
	{
		character.sheetFaceId = 0;
		_runtime = false;
	}
}
