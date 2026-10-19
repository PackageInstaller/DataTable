namespace Sirenix.Serialization.Utilities;

internal delegate object WeakValueGetter(ref object instance);
internal delegate FieldType WeakValueGetter<FieldType>(ref object instance);
