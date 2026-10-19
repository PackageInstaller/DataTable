namespace System.Runtime.Serialization.Formatters.Binary;

[Serializable]
internal sealed class SizedArray : ICloneable
{
	internal object[] objects;

	internal object[] negObjects;

	internal object this[int index]
	{
		get
		{
			if (index < 0)
			{
				if (-index > negObjects.Length - 1)
				{
					return null;
				}
				return negObjects[-index];
			}
			if (index > objects.Length - 1)
			{
				return null;
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
				return;
			}
			if (index > objects.Length - 1)
			{
				IncreaseCapacity(index);
			}
			_ = objects[index];
			objects[index] = value;
		}
	}

	internal SizedArray()
	{
		objects = new object[16];
		negObjects = new object[4];
	}

	internal SizedArray(int length)
	{
		objects = new object[length];
		negObjects = new object[length];
	}

	private SizedArray(SizedArray sizedArray)
	{
		objects = new object[sizedArray.objects.Length];
		sizedArray.objects.CopyTo(objects, 0);
		negObjects = new object[sizedArray.negObjects.Length];
		sizedArray.negObjects.CopyTo(negObjects, 0);
	}

	public object Clone()
	{
		return new SizedArray(this);
	}

	internal void IncreaseCapacity(int index)
	{
		try
		{
			if (index < 0)
			{
				object[] destinationArray = new object[Math.Max(negObjects.Length * 2, -index + 1)];
				Array.Copy(negObjects, 0, destinationArray, 0, negObjects.Length);
				negObjects = destinationArray;
			}
			else
			{
				object[] destinationArray2 = new object[Math.Max(objects.Length * 2, index + 1)];
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
