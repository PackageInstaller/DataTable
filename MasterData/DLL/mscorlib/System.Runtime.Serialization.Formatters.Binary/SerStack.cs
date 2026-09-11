namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class SerStack
{
	internal object[] objects = new object[5];

	internal string stackId;

	internal int top = -1;

	internal SerStack(string stackId)
	{
		this.stackId = stackId;
	}

	internal void Push(object obj)
	{
		if (top == objects.Length - 1)
		{
			IncreaseCapacity();
		}
		objects[++top] = obj;
	}

	internal object Pop()
	{
		if (top < 0)
		{
			return null;
		}
		object result = objects[top];
		objects[top--] = null;
		return result;
	}

	internal void IncreaseCapacity()
	{
		object[] destinationArray = new object[objects.Length * 2];
		Array.Copy(objects, 0, destinationArray, 0, objects.Length);
		objects = destinationArray;
	}

	internal object Peek()
	{
		if (top < 0)
		{
			return null;
		}
		return objects[top];
	}

	internal object PeekPeek()
	{
		if (top < 1)
		{
			return null;
		}
		return objects[top - 1];
	}

	internal bool IsEmpty()
	{
		if (top > 0)
		{
			return false;
		}
		return true;
	}
}
