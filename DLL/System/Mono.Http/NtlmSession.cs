using System;
using System.Net;
using Mono.Security.Protocol.Ntlm;

namespace Mono.Http;

internal class NtlmSession
{
	private MessageBase message;

	public Authorization Authenticate(string challenge, WebRequest webRequest, ICredentials credentials)
	{
		//IL_0091: Unknown result type (might be due to invalid IL or missing references)
		//IL_0098: Expected O, but got Unknown
		//IL_00af: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_0139: Unknown result type (might be due to invalid IL or missing references)
		//IL_0140: Expected O, but got Unknown
		//IL_00ec: Unknown result type (might be due to invalid IL or missing references)
		//IL_0101: Expected O, but got Unknown
		//IL_00fc: Unknown result type (might be due to invalid IL or missing references)
		//IL_0103: Expected O, but got Unknown
		if (!(webRequest is HttpWebRequest httpWebRequest))
		{
			return null;
		}
		NetworkCredential credential = credentials.GetCredential(httpWebRequest.RequestUri, "NTLM");
		if (credential == null)
		{
			return null;
		}
		string text = credential.UserName;
		string text2 = credential.Domain;
		string text3 = credential.Password;
		if (text == null || text == "")
		{
			return null;
		}
		if (string.IsNullOrEmpty(text2))
		{
			int num = text.IndexOf('\\');
			if (num == -1)
			{
				num = text.IndexOf('/');
			}
			if (num >= 0)
			{
				text2 = text.Substring(0, num);
				text = text.Substring(num + 1);
			}
		}
		bool finished = false;
		if (message == null)
		{
			Type1Message val = new Type1Message();
			val.Domain = text2;
			val.Host = "";
			((MessageBase)val).Flags = (NtlmFlags)(((MessageBase)val).Flags | 0x80000);
			message = (MessageBase)(object)val;
		}
		else if (message.Type == 1)
		{
			if (challenge == null)
			{
				message = null;
				return null;
			}
			Type2Message val2 = new Type2Message(Convert.FromBase64String(challenge));
			if (text3 == null)
			{
				text3 = "";
			}
			Type3Message val3 = new Type3Message(val2);
			val3.Username = text;
			val3.Password = text3;
			val3.Domain = text2;
			message = (MessageBase)(object)val3;
			finished = true;
		}
		else if (challenge == null || challenge == string.Empty)
		{
			Type1Message val4 = new Type1Message();
			val4.Domain = text2;
			val4.Host = "";
			message = (MessageBase)(object)val4;
		}
		else
		{
			finished = true;
		}
		return new Authorization("NTLM " + Convert.ToBase64String(message.GetBytes()), finished);
	}
}
