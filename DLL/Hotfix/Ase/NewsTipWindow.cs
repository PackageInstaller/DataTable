using System.Linq;
using System.Text;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class NewsTipWindow : UGuiWindowBase
{
	[Header("背景")]
	[SerializeField]
	private RectTransform bgObj;

	[Header("文字")]
	[SerializeField]
	private RectTransform contentObj;

	[Header("文字")]
	[SerializeField]
	private TextMeshProUGUI contentText;

	[Header("播放速度")]
	[SerializeField]
	private float speed;

	[Header("每次移动间隔时间")]
	[SerializeField]
	private float perMoveTime;

	private NewsTipViewModel viewModel;

	private Timer timer;

	private float durationTime;

	private float posX;

	private float posY;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<NewsTipViewModel>();
		BindingSet<NewsTipWindow, NewsTipViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((NewsTipWindow v) => v.CloseWindow).To((NewsTipViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		OpenTimer();
	}

	private void OpenTimer()
	{
		if (speed <= 0f)
		{
			speed = 100f;
		}
		if (!(bgObj == null) && !((Object)(object)contentText == null))
		{
			((TMP_Text)contentText).text = viewModel.content;
			int num = Encoding.UTF8.GetBytes(viewModel.content).Length;
			int num2 = viewModel.content.Count((char c) => c == '<') / 2 * 23;
			int num3 = viewModel.content.Count((char c) => c == '%') * 2;
			float num4 = (float)(num - num2 + num3) * ((TMP_Text)contentText).fontSize / 3f;
			Rect rect = bgObj.rect;
			durationTime = (num4 + rect.width) / speed;
			posX = rect.width / 2f;
			posY = contentObj.rect.height / 2f;
			timer = Timer.Register(perMoveTime, Play, null, isLooped: true, useRealTime: true);
		}
	}

	private void Play()
	{
		if (durationTime <= 0f)
		{
			viewModel.Close();
			return;
		}
		posX -= perMoveTime * speed;
		contentObj.SetLocalPositionX(posX);
		durationTime -= perMoveTime;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		if (timer != null)
		{
			Timer.Cancel(timer);
		}
		Dismiss();
	}

	protected override void OnDestroy()
	{
		if (timer != null)
		{
			Timer.Cancel(timer);
			timer = null;
		}
		base.OnDestroy();
	}
}
