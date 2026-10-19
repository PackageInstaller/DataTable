namespace Sirenix.Utilities;

public delegate void WeakValueSetter(ref object instance, object value);
public delegate void WeakValueSetter<FieldType>(ref object instance, FieldType value);
