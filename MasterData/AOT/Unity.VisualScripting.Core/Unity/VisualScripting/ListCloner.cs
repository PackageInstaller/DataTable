using System;
using System.Collections;

namespace Unity.VisualScripting;

public sealed class ListCloner : Cloner<IList>
{
	public override bool Handles(Type type)
	{
		return typeof(IList).IsAssignableFrom(type);
	}

	public override void FillClone(Type type, ref IList clone, IList original, CloningContext context)
	{
		if (context.tryPreserveInstances)
		{
			for (int i = 0; i < original.Count; i++)
			{
				object original2 = original[i];
				if (i < clone.Count)
				{
					object clone2 = clone[i];
					Cloning.CloneInto(context, ref clone2, original2);
					clone[i] = clone2;
				}
				else
				{
					clone.Add(Cloning.Clone(context, original2));
				}
			}
		}
		else
		{
			for (int j = 0; j < original.Count; j++)
			{
				object original3 = original[j];
				clone.Add(Cloning.Clone(context, original3));
			}
		}
	}
}
