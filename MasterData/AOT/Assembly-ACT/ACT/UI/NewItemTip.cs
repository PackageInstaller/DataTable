using System.Threading;
using ACT.Game.Data;
using ACT.UI.DataProxy;
using Bamboo.Chronos;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class NewItemTip : MonoBehaviour
{
	[SerializeField]
	private Image bg1Image;

	public LocalizeStringEvent nameLocalize;

	public LocalizeStringEvent descLocalize;

	public Animator animator;

	public ItemUIComponentBase item;

	[SerializeField]
	private Sprite[] bg1Sprites;

	public float duration;

	private Tweener _tweener;

	public bool showFinish { get; set; }

	public bool hideFinish { get; set; }

	public bool curItemFinish { get; set; } = true;

	public async UniTask Show(ItemAchieveinfo info, CancellationToken ct = default(CancellationToken))
	{
		showFinish = false;
		hideFinish = false;
		curItemFinish = false;
		gameObject.SetActive(value: true);
		if (_tweener.IsValid())
		{
			_tweener.Cancel();
		}
		nameLocalize.StringReference.TableEntryReference = info.itemName;
		descLocalize.StringReference.TableEntryReference = info.itemDesId;
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get<Item>(info.itemId, 0L);
		item.SetData(itemUnifierProxy, long.MinValue, ItemUIComponentBase.InitType.RewardItem);
		item.UpdatePerformance();
		bg1Image.sprite = bg1Sprites[itemUnifierProxy.Quality - 1];
		animator.Play("Show");
		await UniTask.WaitUntil(() => showFinish, PlayerLoopTiming.Update, ct);
	}

	public async UniTask Hide(CancellationToken ct = default(CancellationToken))
	{
		animator.Play("Hide");
		await UniTask.WaitUntil(() => hideFinish, PlayerLoopTiming.Update, ct);
		curItemFinish = true;
		item.Release();
		gameObject.SetActive(value: false);
	}

	public void SetShowFinish()
	{
		if (!_tweener.IsValid())
		{
			_tweener = UpdateTimer.Default.TweenMs((int)(duration * 1000f), (int t) =>
			{
			}, (bool b) =>
			{
				showFinish = true;
			});
		}
	}

	public void SetHideFinish()
	{
		hideFinish = true;
	}

	public void ForceFinish()
	{
		if (_tweener.IsValid())
		{
			_tweener.Cancel();
		}
		showFinish = true;
		hideFinish = true;
		curItemFinish = true;
		item.Release();
		gameObject.SetActive(value: false);
	}
}
