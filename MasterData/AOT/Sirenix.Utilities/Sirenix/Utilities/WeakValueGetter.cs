namespace Sirenix.Utilities;

public delegate object WeakValueGetter(ref object instance);
public delegate FieldType WeakValueGetter<FieldType>(ref object instance);
