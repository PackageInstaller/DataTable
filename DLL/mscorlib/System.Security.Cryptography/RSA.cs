using System.Runtime.InteropServices;
using System.Security.Util;
using System.Text;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class RSA : AsymmetricAlgorithm
{
	public static RSA Create()
	{
		return new RSACryptoServiceProvider();
	}

	public virtual byte[] EncryptValue(byte[] rgb)
	{
		throw new NotSupportedException(Environment.GetResourceString("Method is not supported."));
	}

	public override void FromXmlString(string xmlString)
	{
		if (xmlString == null)
		{
			throw new ArgumentNullException("xmlString");
		}
		RSAParameters parameters = default(RSAParameters);
		SecurityElement topElement = new Parser(xmlString).GetTopElement();
		string text = topElement.SearchForTextOfLocalName("Modulus");
		if (text == null)
		{
			throw new CryptographicException(Environment.GetResourceString("Input string does not contain a valid encoding of the '{0}' '{1}' parameter.", "RSA", "Modulus"));
		}
		parameters.Modulus = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text));
		string text2 = topElement.SearchForTextOfLocalName("Exponent");
		if (text2 == null)
		{
			throw new CryptographicException(Environment.GetResourceString("Input string does not contain a valid encoding of the '{0}' '{1}' parameter.", "RSA", "Exponent"));
		}
		parameters.Exponent = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text2));
		string text3 = topElement.SearchForTextOfLocalName("P");
		if (text3 != null)
		{
			parameters.P = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text3));
		}
		string text4 = topElement.SearchForTextOfLocalName("Q");
		if (text4 != null)
		{
			parameters.Q = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text4));
		}
		string text5 = topElement.SearchForTextOfLocalName("DP");
		if (text5 != null)
		{
			parameters.DP = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text5));
		}
		string text6 = topElement.SearchForTextOfLocalName("DQ");
		if (text6 != null)
		{
			parameters.DQ = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text6));
		}
		string text7 = topElement.SearchForTextOfLocalName("InverseQ");
		if (text7 != null)
		{
			parameters.InverseQ = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text7));
		}
		string text8 = topElement.SearchForTextOfLocalName("D");
		if (text8 != null)
		{
			parameters.D = Convert.FromBase64String(Utils.DiscardWhiteSpaces(text8));
		}
		ImportParameters(parameters);
	}

	public override string ToXmlString(bool includePrivateParameters)
	{
		RSAParameters rSAParameters = ExportParameters(includePrivateParameters);
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("<RSAKeyValue>");
		stringBuilder.Append("<Modulus>" + Convert.ToBase64String(rSAParameters.Modulus) + "</Modulus>");
		stringBuilder.Append("<Exponent>" + Convert.ToBase64String(rSAParameters.Exponent) + "</Exponent>");
		if (includePrivateParameters)
		{
			stringBuilder.Append("<P>" + Convert.ToBase64String(rSAParameters.P) + "</P>");
			stringBuilder.Append("<Q>" + Convert.ToBase64String(rSAParameters.Q) + "</Q>");
			stringBuilder.Append("<DP>" + Convert.ToBase64String(rSAParameters.DP) + "</DP>");
			stringBuilder.Append("<DQ>" + Convert.ToBase64String(rSAParameters.DQ) + "</DQ>");
			stringBuilder.Append("<InverseQ>" + Convert.ToBase64String(rSAParameters.InverseQ) + "</InverseQ>");
			stringBuilder.Append("<D>" + Convert.ToBase64String(rSAParameters.D) + "</D>");
		}
		stringBuilder.Append("</RSAKeyValue>");
		return stringBuilder.ToString();
	}

	public abstract RSAParameters ExportParameters(bool includePrivateParameters);

	public abstract void ImportParameters(RSAParameters parameters);
}
