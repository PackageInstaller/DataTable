namespace Bamboo.ECS;

public delegate void EntityAction(Entity entity);
public delegate void EntityAction<T1>(Entity entity, T1 arg1);
public delegate void EntityAction<T1, T2>(Entity entity, T1 arg1, T2 arg2);
public delegate void EntityAction<T1, T2, T3>(Entity entity, T1 arg1, T2 arg2, T3 arg3);
public delegate void EntityAction<T1, T2, T3, T4>(Entity entity, T1 arg1, T2 arg2, T3 arg3, T4 arg4);
public delegate void EntityAction<T1, T2, T3, T4, T5>(Entity entity, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5);
public delegate void EntityAction<T1, T2, T3, T4, T5, T6>(Entity entity, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6);
public delegate void EntityAction<T1, T2, T3, T4, T5, T6, T7>(Entity entity, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7);
public delegate void EntityAction<T1, T2, T3, T4, T5, T6, T7, T8>(Entity entity, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8);
public delegate void EntityAction<T1, T2, T3, T4, T5, T6, T7, T8, T9>(Entity entity, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9);
