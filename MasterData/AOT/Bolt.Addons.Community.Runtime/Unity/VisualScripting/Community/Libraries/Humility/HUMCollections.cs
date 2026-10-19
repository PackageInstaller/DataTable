using System.Collections;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMCollections
{
	public static class Data
	{
		public struct Move
		{
			public IList collection;

			public Move(IList collection, int itemIndex)
			{
				this.collection = collection;
			}

			public Move(IList collection)
			{
				this.collection = collection;
			}
		}

		public struct MoveItem(Move move, object item)
		{
			public Move move = move;

			public object item = item;
		}

		public struct MoveIndex(Move move, int index)
		{
			public Move move = move;

			public int index = index;
		}
	}

	public static Data.Move Move(this IList list, int itemIndex)
	{
		return new Data.Move(list);
	}
}
