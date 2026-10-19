using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class MessageboardReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static MessageboardReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("ChJtZXNzYWdlYm9hcmQucHJvdG8SAnBiGgxjb21tb24ucHJvdG8iQQoPTWVz" + "c2FnZUJvYXJkTnRmEi4KEG1lc3NhZ2VCb2FyZEluZm8YASABKAsyFC5wYi5N" + "ZXNzYWdlQm9hcmRJbmZvIi0KGE1lc3NhZ2VCb2FyZEFkZFN5bnRheE50ZhIR" + "CglzeW50YXhJZHMYASADKAUiLwoZTWVzc2FnZUJvYXJkQWRkQ29udGVudE50" + "ZhISCgpjb250ZW50SWRzGAEgAygFIj4KD1NjZW5lTWVzc2FnZU50ZhIrCg1z" + "Y2VuZU1lc3NhZ2VzGAEgAygLMhQucGIuU2NlbmVNZXNzYWdlSW5mbyJvChVT" + "Y2VuZU1lc3NhZ2VDcmVhdGVSZXESEAoIc3ludGF4SWQYASABKAUSEgoKY29u" + "dGVudElkcxgCIAMoBRIPCgdzdHlsZUlkGAMgASgFEh8KCHBvc2l0aW9uGAQg" + "ASgLMg0ucGIuUEJWZWN0b3IzIkEKFVNjZW5lTWVzc2FnZUNyZWF0ZUFjaxIo" + "CgpuZXdNZXNzYWdlGAEgASgLMhQucGIuU2NlbmVNZXNzYWdlSW5mbyIqChVT" + "Y2VuZU1lc3NhZ2VEZWxldGVSZXESEQoJbWVzc2FnZUlkGAEgASgDIhcKFVNj" + "ZW5lTWVzc2FnZURlbGV0ZUFjayI5ChNTY2VuZU1lc3NhZ2VMaWtlUmVxEhEK" + "CW1lc3NhZ2VJZBgBIAEoAxIPCgdlbW9qaUlkGAIgASgFIhUKE1NjZW5lTWVz" + "c2FnZUxpa2VBY2siGAoWTWVzc2FnZUJvYXJkUmVmcmVzaFJlcSKqAQoWTWVz" + "c2FnZUJvYXJkUmVmcmVzaEFjaxJECg1vd25lZE1lc3NhZ2VzGAEgAygLMi0u" + "cGIuTWVzc2FnZUJvYXJkUmVmcmVzaEFjay5Pd25lZE1lc3NhZ2VzRW50cnka" + "SgoST3duZWRNZXNzYWdlc0VudHJ5EgsKA2tleRgBIAEoAxIjCgV2YWx1ZRgC" + "IAEoCzIULnBiLlNjZW5lTWVzc2FnZUluZm86AjgBIicKElNjZW5lTWVzc2Fn" + "ZVNldFJlcRIRCglpc1JlZnJlc2gYASABKAgiFAoSU2NlbmVNZXNzYWdlU2V0" + "QWNrYgZwcm90bzM="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[14]
		{
			new GeneratedClrTypeInfo(typeof(MessageBoardNtf), MessageBoardNtf.Parser, new string[1] { "MessageBoardInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MessageBoardAddSyntaxNtf), MessageBoardAddSyntaxNtf.Parser, new string[1] { "SyntaxIds" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MessageBoardAddContentNtf), MessageBoardAddContentNtf.Parser, new string[1] { "ContentIds" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneMessageNtf), SceneMessageNtf.Parser, new string[1] { "SceneMessages" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneMessageCreateReq), SceneMessageCreateReq.Parser, new string[4] { "SyntaxId", "ContentIds", "StyleId", "Position" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneMessageCreateAck), SceneMessageCreateAck.Parser, new string[1] { "NewMessage" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneMessageDeleteReq), SceneMessageDeleteReq.Parser, new string[1] { "MessageId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneMessageDeleteAck), SceneMessageDeleteAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneMessageLikeReq), SceneMessageLikeReq.Parser, new string[2] { "MessageId", "EmojiId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneMessageLikeAck), SceneMessageLikeAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MessageBoardRefreshReq), MessageBoardRefreshReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MessageBoardRefreshAck), MessageBoardRefreshAck.Parser, new string[1] { "OwnedMessages" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(SceneMessageSetReq), SceneMessageSetReq.Parser, new string[1] { "IsRefresh" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneMessageSetAck), SceneMessageSetAck.Parser, null, null, null, null, null)
		}));
	}
}
