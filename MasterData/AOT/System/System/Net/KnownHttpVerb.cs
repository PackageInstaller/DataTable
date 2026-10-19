using System.Collections.Specialized;

namespace System.Net;

internal class KnownHttpVerb
{
	internal string Name;

	internal bool RequireContentBody;

	internal bool ContentBodyNotAllowed;

	internal bool ConnectRequest;

	internal bool ExpectNoContentResponse;

	private static ListDictionary NamedHeaders;

	internal static KnownHttpVerb Get;

	internal static KnownHttpVerb Connect;

	internal static KnownHttpVerb Head;

	internal static KnownHttpVerb Put;

	internal static KnownHttpVerb Post;

	internal static KnownHttpVerb MkCol;

	internal KnownHttpVerb(string name, bool requireContentBody, bool contentBodyNotAllowed, bool connectRequest, bool expectNoContentResponse)
	{
		Name = name;
		RequireContentBody = requireContentBody;
		ContentBodyNotAllowed = contentBodyNotAllowed;
		ConnectRequest = connectRequest;
		ExpectNoContentResponse = expectNoContentResponse;
	}

	static KnownHttpVerb()
	{
		NamedHeaders = new ListDictionary(CaseInsensitiveAscii.StaticInstance);
		Get = new KnownHttpVerb("GET", requireContentBody: false, contentBodyNotAllowed: true, connectRequest: false, expectNoContentResponse: false);
		Connect = new KnownHttpVerb("CONNECT", requireContentBody: false, contentBodyNotAllowed: true, connectRequest: true, expectNoContentResponse: false);
		Head = new KnownHttpVerb("HEAD", requireContentBody: false, contentBodyNotAllowed: true, connectRequest: false, expectNoContentResponse: true);
		Put = new KnownHttpVerb("PUT", requireContentBody: true, contentBodyNotAllowed: false, connectRequest: false, expectNoContentResponse: false);
		Post = new KnownHttpVerb("POST", requireContentBody: true, contentBodyNotAllowed: false, connectRequest: false, expectNoContentResponse: false);
		MkCol = new KnownHttpVerb("MKCOL", requireContentBody: false, contentBodyNotAllowed: false, connectRequest: false, expectNoContentResponse: false);
		NamedHeaders[Get.Name] = Get;
		NamedHeaders[Connect.Name] = Connect;
		NamedHeaders[Head.Name] = Head;
		NamedHeaders[Put.Name] = Put;
		NamedHeaders[Post.Name] = Post;
		NamedHeaders[MkCol.Name] = MkCol;
	}

	public static KnownHttpVerb Parse(string name)
	{
		KnownHttpVerb knownHttpVerb = NamedHeaders[name] as KnownHttpVerb;
		if (knownHttpVerb == null)
		{
			knownHttpVerb = new KnownHttpVerb(name, requireContentBody: false, contentBodyNotAllowed: false, connectRequest: false, expectNoContentResponse: false);
		}
		return knownHttpVerb;
	}
}
