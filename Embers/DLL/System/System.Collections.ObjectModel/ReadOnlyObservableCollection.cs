using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Diagnostics;

namespace System.Collections.ObjectModel;

[Serializable]
[DebuggerDisplay("Count = {Count}")]
[DebuggerTypeProxy(typeof(CollectionDebugView<>))]
public class ReadOnlyObservableCollection<T> : ReadOnlyCollection<T>, INotifyCollectionChanged, INotifyPropertyChanged
{
	event NotifyCollectionChangedEventHandler INotifyCollectionChanged.CollectionChanged
	{
		add
		{
			CollectionChanged += value;
		}
		remove
		{
			CollectionChanged -= value;
		}
	}

	[field: NonSerialized]
	protected virtual event NotifyCollectionChangedEventHandler CollectionChanged;

	event PropertyChangedEventHandler INotifyPropertyChanged.PropertyChanged
	{
		add
		{
			PropertyChanged += value;
		}
		remove
		{
			PropertyChanged -= value;
		}
	}

	[field: NonSerialized]
	protected virtual event PropertyChangedEventHandler PropertyChanged;

	public ReadOnlyObservableCollection(ObservableCollection<T> list)
		: base((IList<T>)list)
	{
		((INotifyCollectionChanged)base.Items).CollectionChanged += HandleCollectionChanged;
		((INotifyPropertyChanged)base.Items).PropertyChanged += HandlePropertyChanged;
	}

	protected virtual void OnCollectionChanged(NotifyCollectionChangedEventArgs args)
	{
		if (CollectionChanged != null)
		{
			CollectionChanged(this, args);
		}
	}

	protected virtual void OnPropertyChanged(PropertyChangedEventArgs args)
	{
		if (PropertyChanged != null)
		{
			PropertyChanged(this, args);
		}
	}

	private void HandleCollectionChanged(object sender, NotifyCollectionChangedEventArgs e)
	{
		OnCollectionChanged(e);
	}

	private void HandlePropertyChanged(object sender, PropertyChangedEventArgs e)
	{
		OnPropertyChanged(e);
	}
}
