LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1601821/cfg_skill_view_2001821.lua         &     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � �A  B  A� �� �� �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               ��       PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2589,audioType=1; PlayCasterBindEffect,effectID=160182103; PlayCasterBindEffect,effectID=160182105; PlayCasterMaterialAnim,animName=eff_1601821_chain1_mat; Wait,waitTime = 800; DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=160182104,label=hitAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=hitAgain;        � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime = 2000;         &                                                                                                                        key	   &   config!   &      _ENV