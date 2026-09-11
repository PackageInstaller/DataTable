using System.Collections.Generic;
using UnityEngine;

namespace P08.Quiz;

public sealed class QuizChoiceAreaManagerMono : MonoSingleton<QuizChoiceAreaManagerMono>
{
	public List<QuizChoiceAreaMono> areas = new List<QuizChoiceAreaMono>();

	public Bounds moveArea = new Bounds(Vector3.zero, Vector3.one);

	private void Update()
	{
		CheckLocalPlayerInRange();
	}

	internal void CheckLocalPlayerInRange()
	{
		bool flag = false;
		for (int i = 0; i < areas.Count; i++)
		{
			QuizChoiceAreaMono quizChoiceAreaMono = areas[i];
			quizChoiceAreaMono.HighlightArea(highlight: false);
			if (!flag)
			{
				flag = quizChoiceAreaMono.CheckLocalPlayerInRange();
				if (flag)
				{
					quizChoiceAreaMono.HighlightArea(highlight: true);
				}
			}
		}
	}
}
