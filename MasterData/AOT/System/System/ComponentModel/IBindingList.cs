using System.Collections;

namespace System.ComponentModel;

public interface IBindingList : IList, ICollection, IEnumerable
{
	bool AllowNew { get; }

	bool AllowEdit { get; }

	bool AllowRemove { get; }

	bool SupportsChangeNotification { get; }

	bool SupportsSearching { get; }

	bool SupportsSorting { get; }

	bool IsSorted { get; }

	PropertyDescriptor SortProperty { get; }

	ListSortDirection SortDirection { get; }

	object AddNew();

	void AddIndex(PropertyDescriptor property);

	void ApplySort(PropertyDescriptor property, ListSortDirection direction);

	int Find(PropertyDescriptor property, object key);

	void RemoveIndex(PropertyDescriptor property);

	void RemoveSort();
}
