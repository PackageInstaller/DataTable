LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2905601/cfg_skill_view_290560103.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �y       PlayAudio,audioID=290560107,audioType=1; PlayCasterAnimation,animName=Skill03; PlayCasterBindEffect,effectID =290560112; PlayEffectOffsetScopeCenter,effectID=290560113,offset=0|0; PlayCasterMaterialAnim,animName=PARAM.animName; Wait,waitTime=1500; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; �       DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=doAgain; PlayTargetAddBuff,buffID=20026012; PlayTargetAddBuff,buffID=20026011; PlayTargetAddBuff,buffID=29056012; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         %                                                                                                                     key   %   config    %      _ENV