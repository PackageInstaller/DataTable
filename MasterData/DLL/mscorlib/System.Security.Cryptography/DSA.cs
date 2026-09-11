using System.Runtime.InteropServices;
using System.Security.Util;
using System.Text;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class DSA : AsymmetricAlgorithm
{
	public static DSA Create()
	{
		return new DSACryptoServiceProvider();
	}

	public abstract bool VerifySignature(byte[] rgbHash, byte[] rgbSignature);

	public override void FromXmlString(string xmlString)
	{
		if (xmlString == null)
		{
			throw new ArgumentNullException("xmlString");
		}
		DSAParameters parameters = default(DSAParameters);
		SecurityElement topElement = new Parser(xmlString).GetTopElement();
		string text = topElement.SearchForTextOfLocalName("P");
		if (text == null)
		{
			throw new CryptographicException(Environment.GetResourceString("Input string does not contain a valid encoding of the '{0}' '{1}' parameter.", "DSA", "P"));
		}
		parameters.P = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text));
		string text2 = topElement.SearchForTextOfLocalName("Q");
		if (text2 == null)
		{
			throw new CryptographicException(Environment.GetResourceString("Input string does not contain a valid encoding of the '{0}' '{1}' parameter.", "DSA", "Q"));
		}
		parameters.Q = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text2));
		string text3 = topElement.SearchForTextOfLocalName("G");
		if (text3 == null)
		{
			throw new CryptographicException(Environment.GetResourceString("Input string does not contain a valid encoding of the '{0}' '{1}' parameter.", "DSA", "G"));
		}
		parameters.G = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text3));
		string text4 = topElement.SearchForTextOfLocalName("Y");
		if (text4 == null)
		{
			throw new CryptographicException(Environment.GetResourceString("Input string does not contain a valid encoding of the '{0}' '{1}' parameter.", "DSA", "Y"));
		}
		parameters.Y = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text4));
		string text5 = topElement.SearchForTextOfLocalName("J");
		if (text5 != null)
		{
			parameters.J = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text5));
		}
		string text6 = topElement.SearchForTextOfLocalName("X");
		if (text6 != null)
		{
			parameters.X = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text6));
		}
		string text7 = topElement.SearchForTextOfLocalName("Seed");
		string text8 = topElement.SearchForTextOfLocalName("PgenCounter");
		if (text7 != null && text8 != null)
		{
			parameters.Seed = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text7));
			parameters.Counter = Utils.ConvertByteArrayToInt(Convert.FromBase64String(Utils.DiscardWhiteSpaces(text8)));
		}
		else if (text7 != null || text8 != null)
		{
			if (text7 == null)
			{
				throw new CryptographicException(Environment.GetResourceString("Input string does not contain a valid encoding of the '{0}' '{1}' parameter.", "DSA", "Seed"));
			}
			throw new CryptographicException(Environment.GetResourceString("Input string does not contain a valid encoding of the '{0}' '{1}' parameter.", "DSA", "PgenCounter"));
		}
		ImportParameters(parameters);
	}

	public override string ToXmlString(bool includePrivateParameters)
	{
		DSAParameters dSAParameters = ExportParameters(includePrivateParameters);
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("<DSAKeyValue>");
		stringBuilder.Append("<P>" + Convert.ToBase64String(dSAParameters.P) + "</P>");
		stringBuilder.Append("<Q>" + Convert.ToBase64String(dSAParameters.Q) + "</Q>");
		stringBuilder.Append("<G>" + Convert.ToBase64String(dSAParameters.G) + "</G>");
		stringBuilder.Append("<Y>" + Convert.ToBase64String(dSAParameters.Y) + "</Y>");
		if (dSAParameters.J != null)
		{
			stringBuilder.Append("<J>" + Convert.ToBase64String(dSAParameters.J) + "</J>");
		}
		if (dSAParameters.Seed != null)
		{
			stringBuilder.Append("<Seed>" + Convert.ToBase64String(dSAParameters.Seed) + "</Seed>");
			stringBuilder.Append("<PgenCounter>" + Convert.ToBase64String(Utils.ConvertIntToByteArray(dSAParameters.Counter)) + "</PgenCounter>");
		}
		if (includePrivateParameters)
		{
			stringBuilder.Append("<X>" + Convert.ToBase64String(dSAParameters.X) + "</X>");
		}
		stringBuilder.Append("</DSAKeyValue>");
		return stringBuilder.ToString();
	}

	public abstract DSAParameters ExportParameters(bool includePrivateParameters);

	public abstract void ImportParameters(DSAParameters parameters);
}
