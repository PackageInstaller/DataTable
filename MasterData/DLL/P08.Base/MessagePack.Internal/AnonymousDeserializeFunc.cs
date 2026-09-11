namespace MessagePack.Internal;

internal delegate T AnonymousDeserializeFunc<T>(object[] customFormatters, ref MessagePackReader reader, MessagePackSerializerOptions options);
