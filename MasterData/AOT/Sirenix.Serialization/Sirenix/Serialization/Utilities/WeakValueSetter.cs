namespace Sirenix.Serialization.Utilities;

internal delegate void WeakValueSetter(ref object instance, object value);
internal delegate void WeakValueSetter<FieldType>(ref object instance, FieldType value);
