using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Scripting;

namespace UnityEngine.Windows.Speech;

public abstract class PhraseRecognizer
{
	public delegate void PhraseRecognizedDelegate(PhraseRecognizedEventArgs args);

	protected IntPtr m_Recognizer;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private PhraseRecognizedDelegate OnPhraseRecognized;

	[RequiredByNativeCode]
	private void InvokePhraseRecognizedEvent(string text, ConfidenceLevel confidence, SemanticMeaning[] semanticMeanings, long phraseStartFileTime, long phraseDurationTicks)
	{
		OnPhraseRecognized?.Invoke(new PhraseRecognizedEventArgs(text, confidence, semanticMeanings, DateTime.FromFileTime(phraseStartFileTime), TimeSpan.FromTicks(phraseDurationTicks)));
	}

	[RequiredByNativeCode]
	private unsafe static SemanticMeaning[] MarshalSemanticMeaning(IntPtr keys, IntPtr values, IntPtr valueSizes, int valueCount)
	{
		SemanticMeaning[] array = new SemanticMeaning[valueCount];
		int num = 0;
		for (int i = 0; i < valueCount; i++)
		{
			uint num2 = ((uint*)(void*)valueSizes)[i];
			SemanticMeaning semanticMeaning = new SemanticMeaning
			{
				key = new string(((char**)(void*)keys)[i]),
				values = new string[num2]
			};
			for (int j = 0; j < num2; j++)
			{
				semanticMeaning.values[j] = new string(((char**)(void*)values)[num + j]);
			}
			array[i] = semanticMeaning;
			num += (int)num2;
		}
		return array;
	}
}
