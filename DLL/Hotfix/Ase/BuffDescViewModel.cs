using System.Collections.Generic;
using System.Collections.Specialized;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BuffDescViewModel : OptionBase
{
	private int continuedShowCount;

	private int noContinuedShowCount;

	private ObservableList<BuffItemViewModel> buffList;

	private RectTransform pos;

	private List<BuffItemViewModel> buffVMs = new List<BuffItemViewModel>();

	private InteractionRequest updateDescRequest = new InteractionRequest();

	public List<BuffItemViewModel> BuffVMs => buffVMs;

	public ObservableList<BuffItemViewModel> BuffPre => buffList;

	public IInteractionRequest UpdateDescRequest => updateDescRequest;

	public RectTransform Pos => pos;

	public BuffDescViewModel()
	{
	}

	public BuffDescViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public void OnShow(OptionBase parent, ObservableList<BuffItemViewModel> buffList, RectTransform pos)
	{
		this.pos = pos;
		base.parent = parent;
		buffVMs.Clear();
		continuedShowCount = 0;
		noContinuedShowCount = 0;
		for (int i = 0; i < buffList.Count; i++)
		{
			if (buffList[i].MaxTime < 0f)
			{
				buffVMs.Add(buffList[i]);
				continuedShowCount++;
			}
			else
			{
				buffVMs.Insert(noContinuedShowCount, buffList[i]);
				noContinuedShowCount++;
			}
		}
		this.buffList = buffList;
		buffList.CollectionChanged += OnBuffListChanged;
		updateDescRequest.Raise();
	}

	private void OnBuffListChanged(object sender, NotifyCollectionChangedEventArgs e)
	{
		switch (e.Action)
		{
		case NotifyCollectionChangedAction.Add:
			foreach (object newItem in e.NewItems)
			{
				if (newItem is BuffItemViewModel buffItemViewModel4)
				{
					if (buffItemViewModel4.MaxTime < 0f)
					{
						buffVMs.Insert(noContinuedShowCount, buffItemViewModel4);
						continuedShowCount++;
					}
					else
					{
						buffVMs.Insert(0, buffItemViewModel4);
						noContinuedShowCount++;
					}
				}
			}
			break;
		case NotifyCollectionChangedAction.Replace:
			foreach (object oldItem in e.OldItems)
			{
				BuffItemViewModel buffItemViewModel3 = oldItem as BuffItemViewModel;
				for (int j = 0; j < buffVMs.Count; j++)
				{
					if (buffVMs[j].Buff == buffItemViewModel3.Buff)
					{
						buffVMs[j] = buffList[e.NewStartingIndex];
						break;
					}
				}
			}
			break;
		case NotifyCollectionChangedAction.Remove:
			foreach (object oldItem2 in e.OldItems)
			{
				BuffItemViewModel buffItemViewModel = oldItem2 as BuffItemViewModel;
				for (int i = 0; i < buffVMs.Count; i++)
				{
					if (buffVMs[i].Buff == buffItemViewModel.Buff)
					{
						BuffItemViewModel buffItemViewModel2 = buffVMs[i];
						buffVMs.Remove(buffItemViewModel2);
						buffVMs.Add(buffItemViewModel2);
						if (buffItemViewModel.MaxTime < 0f)
						{
							buffItemViewModel2.SetNoActive();
							continuedShowCount--;
						}
						else
						{
							noContinuedShowCount--;
						}
						break;
					}
				}
			}
			break;
		}
		updateDescRequest.Raise();
	}

	public override void Close()
	{
		buffList.CollectionChanged -= OnBuffListChanged;
		base.IsVisible = false;
		buffVMs.Clear();
		buffList = null;
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
		foreach (BuffItemViewModel buffVM in buffVMs)
		{
			buffVM?.Dispose();
		}
		BuffVMs.Clear();
		buffList = null;
	}
}
