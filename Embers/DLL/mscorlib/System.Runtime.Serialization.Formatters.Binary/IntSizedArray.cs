namespace System.Runtime.Serialization.Formatters.Binary;

[Serializable]
internal sealed class IntSizedArray : ICloneable
{
	internal int[] objects = new int[16];

	internal int[] negObjects = new int[4];

	internal int this[int index]
	{
		get
		{
			if (index < 0)
			{
				if (-index > negObjects.Length - 1)
				{
					return 0;
				}
				return negObjects[-index];
			}
			if (index > objects.Length - 1)
			{
				return 0;
			}
			return objects[index];
		}
		set
		{
			if (index < 0)
			{
				if (-index > negObjects.Length - 1)
				{
					IncreaseCapacity(index);
				}
				negObjects[-index] = value;
			}
			else
			{
				if (index > objects.Length - 1)
				{
					IncreaseCapacity(index);
				}
				objects[index] = value;
			}
		}
	}

	public IntSizedArray()
	{
	}

	private IntSizedArray(IntSizedArray sizedArray)
	{
		objects = new int[sizedArray.objects.Length];
		sizedArray.objects.CopyTo(objects, 0);
		negObjects = new int[sizedArray.negObjects.Length];
		sizedArray.negObjects.CopyTo(negObjects, 0);
	}

	public object Clone()
	{
		return new IntSizedArray(this);
	}

	internal void IncreaseCapacity(int index)
	{
		try
		{
			if (index < 0)
			{
				int[] destinationArray = new int[Math.Max(negObjects.Length * 2, -index + 1)];
				Array.Copy(negObjects, 0, destinationArray, 0, negObjects.Length);
				negObjects = destinationArray;
			}
			else
			{
				int[] destinationArray2 = new int[Math.Max(objects.Length * 2, index + 1)];
				Array.Copy(objects, 0, destinationArray2, 0, objects.Length);
				objects = destinationArray2;
			}
		}
		catch (Exception)
		{
			throw new SerializationException(Environment.GetResourceString("Invalid BinaryFormatter stream."));
		}
	}
}
