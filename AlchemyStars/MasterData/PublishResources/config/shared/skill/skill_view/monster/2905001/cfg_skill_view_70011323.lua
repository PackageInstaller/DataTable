LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2905001/cfg_skill_view_70011323.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� � kB� �@�� ��  A�  �� ��  B  AB �� �� �B� �@��AA �A �� �  AB  �B �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               d       n PlaySummonTrap,trapID=14,interval=0,effectID=480; PlaySummonDeadTrap,trapID=29050012,interval=0,effectID=0; �      ��       PlayEntityAnimation,animName=birth,trapID=29050012; PlayEntityBindEffect , effectID=290500114,trapID=29050012; PlayAudio,audioID = 6256,audioType=1; PlayTargetMaterialAnim,animName=effanim_29050012_birth; Wait,waitTime=2500; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,delay=0,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; E PlaySummonMonsterBySummonEveryThing,monsterID=70011322,interval=0;         0                                                                                                                                                      key   0   config+   0      _ENV