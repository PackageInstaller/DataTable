using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine.Localization;

namespace ACT.UI;

public class MonoPopUpRegionTip : BaseUIView
{
	public TextMeshProUGUI text;

	public float time = 1f;

	private CancellationTokenSource m_Cts;

	protected override void Init()
	{
		if (uiViewData is LocalizedString localizedString)
		{
			text.text = localizedString.GetLocalizedString();
			m_Cts?.Cancel();
			m_Cts = new CancellationTokenSource();
			WaitClose(m_Cts.Token).Forget();
		}
	}

	private async UniTask WaitClose(CancellationToken token)
	{
		await UniTask.Delay(TimeSpan.FromSeconds(time), DelayType.DeltaTime, PlayerLoopTiming.Update, token);
		if (!token.IsCancellationRequested)
		{
			Close();
			m_Cts?.Cancel();
			m_Cts = null;
		}
	}
}
