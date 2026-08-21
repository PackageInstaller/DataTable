namespace MessagePack.Internal;

internal delegate void AnonymousSerializeFunc<T>(byte[][] stringByteKeysField, object[] customFormatters, ref MessagePackWriter writer, T value, MessagePackSerializerOptions options);
