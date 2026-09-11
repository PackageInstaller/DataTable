using System.Text;

namespace System.Net.NetworkInformation;

public class PhysicalAddress
{
	private byte[] address;

	private bool changed = true;

	private int hash;

	public static readonly PhysicalAddress None = new PhysicalAddress(new byte[0]);

	public PhysicalAddress(byte[] address)
	{
		this.address = address;
	}

	public override int GetHashCode()
	{
		if (changed)
		{
			changed = false;
			hash = 0;
			int num = address.Length & -4;
			int i;
			for (i = 0; i < num; i += 4)
			{
				hash ^= address[i] | (address[i + 1] << 8) | (address[i + 2] << 16) | (address[i + 3] << 24);
			}
			if ((address.Length & 3) != 0)
			{
				int num2 = 0;
				int num3 = 0;
				for (; i < address.Length; i++)
				{
					num2 |= address[i] << num3;
					num3 += 8;
				}
				hash ^= num2;
			}
		}
		return hash;
	}

	public override bool Equals(object comparand)
	{
		if (!(comparand is PhysicalAddress physicalAddress))
		{
			return false;
		}
		if (address.Length != physicalAddress.address.Length)
		{
			return false;
		}
		for (int i = 0; i < physicalAddress.address.Length; i++)
		{
			if (address[i] != physicalAddress.address[i])
			{
				return false;
			}
		}
		return true;
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		byte[] array = address;
		foreach (byte b in array)
		{
			int num = (b >> 4) & 0xF;
			for (int j = 0; j < 2; j++)
			{
				if (num < 10)
				{
					stringBuilder.Append((char)(num + 48));
				}
				else
				{
					stringBuilder.Append((char)(num + 55));
				}
				num = b & 0xF;
			}
		}
		return stringBuilder.ToString();
	}
}
