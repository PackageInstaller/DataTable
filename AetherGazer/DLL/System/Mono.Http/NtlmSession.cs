using System;
using System.Net;
using Mono.Security.Protocol.Ntlm;

namespace Mono.Http;

internal class NtlmSession
{
	private MessageBase message;

	public Authorization Authenticate(string challenge, WebRequest webRequest, ICredentials credentials)
	{
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
			Type1Message type1Message = new Type1Message();
			type1Message.Domain = text2;
			type1Message.Host = "";
			type1Message.Flags |= NtlmFlags.NegotiateNtlm2Key;
			message = type1Message;
		}
		else if (message.Type == 1)
		{
			if (challenge == null)
			{
				message = null;
				return null;
			}
			Type2Message type = new Type2Message(Convert.FromBase64String(challenge));
			if (text3 == null)
			{
				text3 = "";
			}
			Type3Message type3Message = new Type3Message(type);
			type3Message.Username = text;
			type3Message.Password = text3;
			type3Message.Domain = text2;
			message = type3Message;
			finished = true;
		}
		else if (challenge == null || challenge == string.Empty)
		{
			Type1Message type1Message2 = new Type1Message();
			type1Message2.Domain = text2;
			type1Message2.Host = "";
			message = type1Message2;
		}
		else
		{
			finished = true;
		}
		return new Authorization("NTLM " + Convert.ToBase64String(message.GetBytes()), finished);
	}
}
