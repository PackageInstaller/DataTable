namespace UnityEngine.Localization.Pseudo;

public class Mirror : IPseudoLocalizationMethod
{
	public void Transform(Message message)
	{
		foreach (MessageFragment fragment in message.Fragments)
		{
			if (fragment is WritableMessageFragment writableMessageFragment)
			{
				MirrorFragment(writableMessageFragment);
			}
		}
	}

	private void MirrorFragment(WritableMessageFragment writableMessageFragment)
	{
		char[] array = new char[writableMessageFragment.Length];
		int num = writableMessageFragment.Length - 1;
		int num3;
		for (int num2 = writableMessageFragment.Length - 1; num2 >= 0; num2--)
		{
			if (writableMessageFragment[num2] == '\n')
			{
				array[num2] = '\n';
				num3 = num2 + 1;
				while (num > num2)
				{
					array[num3++] = writableMessageFragment[num--];
				}
				num = num2 - 1;
			}
		}
		num3 = 0;
		while (num >= 0)
		{
			array[num3++] = writableMessageFragment[num--];
		}
		writableMessageFragment.Text = new string(array);
	}
}
