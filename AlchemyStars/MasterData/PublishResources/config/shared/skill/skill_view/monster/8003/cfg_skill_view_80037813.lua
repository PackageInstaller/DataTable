LuaS �

xV           (w@]@../PublishResources/config/shared/skill/skill_view/monster/8003/cfg_skill_view_80037813.lua         <     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A �� �  AB  � ˂  �BE��B@�+A�K��� ��  A�  �B  � � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               D PlayCasterAnimation,animName = AtkUltPreview; Wait,waitTime=2100; � PlayCasterBindEffect,effectID=1242; PlayCasterBindEffect,effectID=1243; PlayCasterAnimation,animName = AtkUlt; Wait,waitTime=3733; +       audioID�      
audioType�       DataSelectDamage,damageIndex=1; PlayEffectAtTargetPos,effectID=1244; Wait,waitTime=2200; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlaySummonTrap,trapID=14;         <                                                                                                                                                                                          key	   <   config7   <      _ENV