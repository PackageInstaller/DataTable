return {
	Play325582001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325582001
		arg_1_1.duration_ = 8.3

		local var_1_0 = {
			zh = 4.8,
			ja = 8.3
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325582002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J26h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J26h")
				var_4_0.name = "J26h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J26h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J26h

				arg_1_1.bgs_.J26h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J26h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "10175ui_story"

			if arg_1_1.actors_["10175ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10175ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10175ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["10175ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10175ui_story = var_4_13.localPosition

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end
			end

			local var_4_15 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_1_1.time_ - 1.8) / var_4_15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1, -6.05)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles

				local var_4_16 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_16 then
					var_4_16:EnableDynamicBone(true)
				end
			end

			local var_4_17 = arg_1_1.actors_["10175ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect10175ui_story == nil then
				arg_1_1.var_.characterEffect10175ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect10175ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_18 and arg_1_1.time_ < 1.8 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect10175ui_story then
				arg_1_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1210", "se_story_1210_blast_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.375

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(325582001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 15 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 15)

				if (15 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 15)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582001", "story_v_out_325582.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_325582", "325582001", "story_v_out_325582.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_325582", "325582001", "story_v_out_325582.awb")

						arg_1_1:RecordAudio("325582001", var_4_32)
						arg_1_1:RecordAudio("325582001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325582", "325582001", "story_v_out_325582.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325582", "325582001", "story_v_out_325582.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325582002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325582002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325582003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos10175ui_story = arg_8_1.actors_["10175ui_story"].transform.localPosition

				local var_11_0 = GameObjectTools.GetOrAddComponent(arg_8_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_11_0 then
					var_11_0:EnableDynamicBone(false)
				end
			end

			local var_11_1 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_1 then
				arg_8_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_1)
				arg_8_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["10175ui_story"].transform.position).z)
				arg_8_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["10175ui_story"].transform.localEulerAngles = arg_8_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_1 and arg_8_1.time_ < 0 + var_11_1 + arg_11_0 then
				arg_8_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["10175ui_story"].transform.position).z)
				arg_8_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["10175ui_story"].transform.localEulerAngles = arg_8_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_11_2 = GameObjectTools.GetOrAddComponent(arg_8_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(true)
				end
			end

			local var_11_3 = arg_8_1.actors_["10175ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect10175ui_story == nil then
				arg_8_1.var_.characterEffect10175ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect10175ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_4)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect10175ui_story then
				arg_8_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 1 < arg_8_1.time_ and arg_8_1.time_ <= 1 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword04", "")
			end

			local var_11_6 = 0
			local var_11_7 = 1.475

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_8 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325582002).content)

				arg_8_1.text_.text = var_11_8

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_10 = 59 <= 0 and var_11_7 or var_11_7 * (utf8.len(var_11_8) / 59)

				if (59 <= 0 and var_11_7 or var_11_7 * (utf8.len(var_11_8) / 59)) > 0 and var_11_7 < var_11_10 then
					arg_8_1.talkMaxDuration = var_11_10

					if var_11_10 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_10 + var_11_6
					end
				end

				arg_8_1.text_.text = var_11_8
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_11 = math.max(var_11_7, arg_8_1.talkMaxDuration)

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_11 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_6) / var_11_11

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_6 + var_11_11 and arg_8_1.time_ < var_11_6 + var_11_11 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play325582003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325582003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325582004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.925

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(325582003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 77 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 77)

				if (77 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 77)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325582004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325582004
		arg_16_1.duration_ = 3.43

		local var_16_0 = {
			zh = 3.433,
			ja = 2.366
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325582005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10175ui_story = arg_16_1.actors_["10175ui_story"].transform.localPosition

				local var_19_0 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_0 then
					var_19_0:EnableDynamicBone(false)
				end
			end

			local var_19_1 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				arg_16_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_16_1.time_ - 0) / var_19_1)
				arg_16_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10175ui_story"].transform.position).z)
				arg_16_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["10175ui_story"].transform.localEulerAngles = arg_16_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 then
				arg_16_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_16_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10175ui_story"].transform.position).z)
				arg_16_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["10175ui_story"].transform.localEulerAngles = arg_16_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_19_2 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(true)
				end
			end

			local var_19_3 = arg_16_1.actors_["10175ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect10175ui_story == nil then
				arg_16_1.var_.characterEffect10175ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect10175ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect10175ui_story then
				arg_16_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action37_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_19_6 = 0
			local var_19_7 = 0.125

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_8 = arg_16_1:GetWordFromCfg(325582004)
				local var_19_9 = arg_16_1:FormatText(var_19_8.content)

				arg_16_1.text_.text = var_19_9

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 5 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_9) / 5)

				if (5 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_9) / 5)) > 0 and var_19_7 < var_19_11 then
					arg_16_1.talkMaxDuration = var_19_11

					if var_19_11 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_11 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_9
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582004", "story_v_out_325582.awb") ~= 0 then
					local var_19_12 = manager.audio:GetVoiceLength("story_v_out_325582", "325582004", "story_v_out_325582.awb") / 1000

					if var_19_12 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_6
					end

					if var_19_8.prefab_name ~= "" and arg_16_1.actors_[var_19_8.prefab_name] ~= nil then
						local var_19_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_8.prefab_name].transform, "story_v_out_325582", "325582004", "story_v_out_325582.awb")

						arg_16_1:RecordAudio("325582004", var_19_13)
						arg_16_1:RecordAudio("325582004", var_19_13)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325582", "325582004", "story_v_out_325582.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325582", "325582004", "story_v_out_325582.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_14 and arg_16_1.time_ < var_19_6 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play325582005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325582005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325582006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos10175ui_story = arg_20_1.actors_["10175ui_story"].transform.localPosition

				local var_23_0 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_0 then
					var_23_0:EnableDynamicBone(false)
				end
			end

			local var_23_1 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_1 then
				arg_20_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_1)
				arg_20_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10175ui_story"].transform.position).z)
				arg_20_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["10175ui_story"].transform.localEulerAngles = arg_20_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_1 and arg_20_1.time_ < 0 + var_23_1 + arg_23_0 then
				arg_20_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10175ui_story"].transform.position).z)
				arg_20_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["10175ui_story"].transform.localEulerAngles = arg_20_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_23_2 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(true)
				end
			end

			local var_23_3 = arg_20_1.actors_["10175ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect10175ui_story == nil then
				arg_20_1.var_.characterEffect10175ui_story = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect10175ui_story and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_4)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect10175ui_story then
				arg_20_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_23_5 = 0
			local var_23_6 = 1.625

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_7 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(325582005).content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 65 <= 0 and var_23_6 or var_23_6 * (utf8.len(var_23_7) / 65)

				if (65 <= 0 and var_23_6 or var_23_6 * (utf8.len(var_23_7) / 65)) > 0 and var_23_6 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_5 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_5
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_6, arg_20_1.talkMaxDuration)

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_5) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_5 + var_23_10 and arg_20_1.time_ < var_23_5 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play325582006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325582006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play325582007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 1.95

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(325582006).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 78 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 78)

				if (78 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 78)) > 0 and var_27_0 < var_27_3 then
					arg_24_1.talkMaxDuration = var_27_3

					if var_27_3 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_3 + 0
					end
				end

				arg_24_1.text_.text = var_27_1
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_4 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_4

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325582007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325582007
		arg_28_1.duration_ = 7.17

		local var_28_0 = {
			zh = 6.933,
			ja = 7.166
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325582008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["10166ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10166ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "10166ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "10166ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["10166ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["10166ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["10166ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["10166ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["10166ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos10166ui_story = var_31_3.localPosition

				local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_3.gameObject, typeof(DynamicBoneHelper))

				if var_31_4 then
					var_31_4:EnableDynamicBone(false)
				end
			end

			local var_31_5 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_5 then
				var_31_3.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10166ui_story, Vector3.New(0, -1.28, -5.73), (arg_28_1.time_ - 0) / var_31_5)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_5 and arg_28_1.time_ < 0 + var_31_5 + arg_31_0 then
				var_31_3.localPosition = Vector3.New(0, -1.28, -5.73)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles

				local var_31_6 = GameObjectTools.GetOrAddComponent(var_31_3.gameObject, typeof(DynamicBoneHelper))

				if var_31_6 then
					var_31_6:EnableDynamicBone(true)
				end
			end

			local var_31_7 = arg_28_1.actors_["10166ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_7) and arg_28_1.var_.characterEffect10166ui_story == nil then
				arg_28_1.var_.characterEffect10166ui_story = var_31_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_8 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_8 and not isNil(var_31_7) then
				if arg_28_1.var_.characterEffect10166ui_story and not isNil(var_31_7) then
					arg_28_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_8 and arg_28_1.time_ < 0 + var_31_8 + arg_31_0 and not isNil(var_31_7) and arg_28_1.var_.characterEffect10166ui_story then
				arg_28_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_31_10 = 0
			local var_31_11 = 0.675

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(325582007)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 27 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 27)

				if (27 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 27)) > 0 and var_31_11 < var_31_15 then
					arg_28_1.talkMaxDuration = var_31_15

					if var_31_15 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_15 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582007", "story_v_out_325582.awb") ~= 0 then
					local var_31_16 = manager.audio:GetVoiceLength("story_v_out_325582", "325582007", "story_v_out_325582.awb") / 1000

					if var_31_16 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_10
					end

					if var_31_12.prefab_name ~= "" and arg_28_1.actors_[var_31_12.prefab_name] ~= nil then
						local var_31_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_12.prefab_name].transform, "story_v_out_325582", "325582007", "story_v_out_325582.awb")

						arg_28_1:RecordAudio("325582007", var_31_17)
						arg_28_1:RecordAudio("325582007", var_31_17)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325582", "325582007", "story_v_out_325582.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325582", "325582007", "story_v_out_325582.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_18 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_18 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_18

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_18 and arg_28_1.time_ < var_31_10 + var_31_18 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play325582008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325582008
		arg_32_1.duration_ = 8.37

		local var_32_0 = {
			zh = 5.066,
			ja = 8.366
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325582009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.5

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:GetWordFromCfg(325582008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 20 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 20)

				if (20 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 20)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582008", "story_v_out_325582.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_325582", "325582008", "story_v_out_325582.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_325582", "325582008", "story_v_out_325582.awb")

						arg_32_1:RecordAudio("325582008", var_35_6)
						arg_32_1:RecordAudio("325582008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325582", "325582008", "story_v_out_325582.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325582", "325582008", "story_v_out_325582.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325582009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325582009
		arg_36_1.duration_ = 5.73

		local var_36_0 = {
			zh = 3.8,
			ja = 5.733
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325582010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos10166ui_story = arg_36_1.actors_["10166ui_story"].transform.localPosition

				local var_39_0 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_0 then
					var_39_0:EnableDynamicBone(false)
				end
			end

			local var_39_1 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_1 then
				arg_36_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10166ui_story, Vector3.New(-0.96, -1.28, -5.73), (arg_36_1.time_ - 0) / var_39_1)
				arg_36_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["10166ui_story"].transform.position).z)
				arg_36_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["10166ui_story"].transform.localEulerAngles = arg_36_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 then
				arg_36_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(-0.96, -1.28, -5.73)
				arg_36_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["10166ui_story"].transform.position).z)
				arg_36_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["10166ui_story"].transform.localEulerAngles = arg_36_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_39_2 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(true)
				end
			end

			local var_39_3 = arg_36_1.actors_["10175ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos10175ui_story = var_39_3.localPosition

				local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_3.gameObject, typeof(DynamicBoneHelper))

				if var_39_4 then
					var_39_4:EnableDynamicBone(false)
				end
			end

			local var_39_5 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_5 then
				var_39_3.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10175ui_story, Vector3.New(0.7, -1, -6.05), (arg_36_1.time_ - 0) / var_39_5)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_5 and arg_36_1.time_ < 0 + var_39_5 + arg_39_0 then
				var_39_3.localPosition = Vector3.New(0.7, -1, -6.05)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles

				local var_39_6 = GameObjectTools.GetOrAddComponent(var_39_3.gameObject, typeof(DynamicBoneHelper))

				if var_39_6 then
					var_39_6:EnableDynamicBone(true)
				end
			end

			local var_39_7 = arg_36_1.actors_["10175ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_7) and arg_36_1.var_.characterEffect10175ui_story == nil then
				arg_36_1.var_.characterEffect10175ui_story = var_39_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_8 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_8 and not isNil(var_39_7) then
				if arg_36_1.var_.characterEffect10175ui_story and not isNil(var_39_7) then
					arg_36_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_8 and arg_36_1.time_ < 0 + var_39_8 + arg_39_0 and not isNil(var_39_7) and arg_36_1.var_.characterEffect10175ui_story then
				arg_36_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_39_10 = arg_36_1.actors_["10166ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_10) and arg_36_1.var_.characterEffect10166ui_story == nil then
				arg_36_1.var_.characterEffect10166ui_story = var_39_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_11 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_11 and not isNil(var_39_10) then
				if arg_36_1.var_.characterEffect10166ui_story and not isNil(var_39_10) then
					arg_36_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_11)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_11 and arg_36_1.time_ < 0 + var_39_11 + arg_39_0 and not isNil(var_39_10) and arg_36_1.var_.characterEffect10166ui_story then
				arg_36_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action37_2")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_39_12 = 0
			local var_39_13 = 0.45

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_14 = arg_36_1:GetWordFromCfg(325582009)
				local var_39_15 = arg_36_1:FormatText(var_39_14.content)

				arg_36_1.text_.text = var_39_15

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 18 <= 0 and var_39_13 or var_39_13 * (utf8.len(var_39_15) / 18)

				if (18 <= 0 and var_39_13 or var_39_13 * (utf8.len(var_39_15) / 18)) > 0 and var_39_13 < var_39_17 then
					arg_36_1.talkMaxDuration = var_39_17

					if var_39_17 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_12
					end
				end

				arg_36_1.text_.text = var_39_15
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582009", "story_v_out_325582.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_325582", "325582009", "story_v_out_325582.awb") / 1000

					if var_39_18 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_12
					end

					if var_39_14.prefab_name ~= "" and arg_36_1.actors_[var_39_14.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_14.prefab_name].transform, "story_v_out_325582", "325582009", "story_v_out_325582.awb")

						arg_36_1:RecordAudio("325582009", var_39_19)
						arg_36_1:RecordAudio("325582009", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325582", "325582009", "story_v_out_325582.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325582", "325582009", "story_v_out_325582.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_20 = math.max(var_39_13, arg_36_1.talkMaxDuration)

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_20 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_12) / var_39_20

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_12 + var_39_20 and arg_36_1.time_ < var_39_12 + var_39_20 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play325582010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325582010
		arg_40_1.duration_ = 5.97

		local var_40_0 = {
			zh = 4.8,
			ja = 5.966
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325582011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["10166ui_story"]) and arg_40_1.var_.characterEffect10166ui_story == nil then
				arg_40_1.var_.characterEffect10166ui_story = arg_40_1.actors_["10166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["10166ui_story"]) then
				if arg_40_1.var_.characterEffect10166ui_story and not isNil(arg_40_1.actors_["10166ui_story"]) then
					arg_40_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["10166ui_story"]) and arg_40_1.var_.characterEffect10166ui_story then
				arg_40_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["10175ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect10175ui_story == nil then
				arg_40_1.var_.characterEffect10175ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect10175ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect10175ui_story then
				arg_40_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_4 = 0
			local var_43_5 = 0.425

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(325582010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 17 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 17)

				if (17 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 17)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582010", "story_v_out_325582.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_325582", "325582010", "story_v_out_325582.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_325582", "325582010", "story_v_out_325582.awb")

						arg_40_1:RecordAudio("325582010", var_43_11)
						arg_40_1:RecordAudio("325582010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325582", "325582010", "story_v_out_325582.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325582", "325582010", "story_v_out_325582.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_12 and arg_40_1.time_ < var_43_4 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325582011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325582011
		arg_44_1.duration_ = 10.9

		local var_44_0 = {
			zh = 5.1,
			ja = 10.9
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325582012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.525

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:GetWordFromCfg(325582011)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 21 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 21)

				if (21 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 21)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582011", "story_v_out_325582.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_325582", "325582011", "story_v_out_325582.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_325582", "325582011", "story_v_out_325582.awb")

						arg_44_1:RecordAudio("325582011", var_47_6)
						arg_44_1:RecordAudio("325582011", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325582", "325582011", "story_v_out_325582.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325582", "325582011", "story_v_out_325582.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play325582012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325582012
		arg_48_1.duration_ = 4.53

		local var_48_0 = {
			zh = 3.033,
			ja = 4.533
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play325582013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["10175ui_story"]) and arg_48_1.var_.characterEffect10175ui_story == nil then
				arg_48_1.var_.characterEffect10175ui_story = arg_48_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["10175ui_story"]) then
				if arg_48_1.var_.characterEffect10175ui_story and not isNil(arg_48_1.actors_["10175ui_story"]) then
					arg_48_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["10175ui_story"]) and arg_48_1.var_.characterEffect10175ui_story then
				arg_48_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["10166ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect10166ui_story == nil then
				arg_48_1.var_.characterEffect10166ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect10166ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect10166ui_story then
				arg_48_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action4_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_51_4 = 0
			local var_51_5 = 0.375

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(325582012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 15 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 15)

				if (15 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 15)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582012", "story_v_out_325582.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_325582", "325582012", "story_v_out_325582.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_325582", "325582012", "story_v_out_325582.awb")

						arg_48_1:RecordAudio("325582012", var_51_11)
						arg_48_1:RecordAudio("325582012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325582", "325582012", "story_v_out_325582.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325582", "325582012", "story_v_out_325582.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play325582013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325582013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play325582014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos10175ui_story = arg_52_1.actors_["10175ui_story"].transform.localPosition

				local var_55_0 = GameObjectTools.GetOrAddComponent(arg_52_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_55_0 then
					var_55_0:EnableDynamicBone(false)
				end
			end

			local var_55_1 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_1 then
				arg_52_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_1)
				arg_52_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["10175ui_story"].transform.position).z)
				arg_52_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["10175ui_story"].transform.localEulerAngles = arg_52_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_1 and arg_52_1.time_ < 0 + var_55_1 + arg_55_0 then
				arg_52_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["10175ui_story"].transform.position).z)
				arg_52_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["10175ui_story"].transform.localEulerAngles = arg_52_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_55_2 = GameObjectTools.GetOrAddComponent(arg_52_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(true)
				end
			end

			local var_55_3 = arg_52_1.actors_["10166ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos10166ui_story = var_55_3.localPosition

				local var_55_4 = GameObjectTools.GetOrAddComponent(var_55_3.gameObject, typeof(DynamicBoneHelper))

				if var_55_4 then
					var_55_4:EnableDynamicBone(false)
				end
			end

			local var_55_5 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_5 then
				var_55_3.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10166ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_5)
				var_55_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_3.position).x, (manager.ui.mainCamera.transform.position - var_55_3.position).y, (manager.ui.mainCamera.transform.position - var_55_3.position).z)
				var_55_3.localEulerAngles.z = 0
				var_55_3.localEulerAngles.x = 0
				var_55_3.localEulerAngles = var_55_3.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_5 and arg_52_1.time_ < 0 + var_55_5 + arg_55_0 then
				var_55_3.localPosition = Vector3.New(0, 100, 0)
				var_55_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_3.position).x, (manager.ui.mainCamera.transform.position - var_55_3.position).y, (manager.ui.mainCamera.transform.position - var_55_3.position).z)
				var_55_3.localEulerAngles.z = 0
				var_55_3.localEulerAngles.x = 0
				var_55_3.localEulerAngles = var_55_3.localEulerAngles

				local var_55_6 = GameObjectTools.GetOrAddComponent(var_55_3.gameObject, typeof(DynamicBoneHelper))

				if var_55_6 then
					var_55_6:EnableDynamicBone(true)
				end
			end

			local var_55_7 = arg_52_1.actors_["10175ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_7) and arg_52_1.var_.characterEffect10175ui_story == nil then
				arg_52_1.var_.characterEffect10175ui_story = var_55_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_8 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_8 and not isNil(var_55_7) then
				if arg_52_1.var_.characterEffect10175ui_story and not isNil(var_55_7) then
					arg_52_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_8)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_8 and arg_52_1.time_ < 0 + var_55_8 + arg_55_0 and not isNil(var_55_7) and arg_52_1.var_.characterEffect10175ui_story then
				arg_52_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_55_9 = 0
			local var_55_10 = 1.35

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_11 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(325582013).content)

				arg_52_1.text_.text = var_55_11

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 54 <= 0 and var_55_10 or var_55_10 * (utf8.len(var_55_11) / 54)

				if (54 <= 0 and var_55_10 or var_55_10 * (utf8.len(var_55_11) / 54)) > 0 and var_55_10 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_9 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_9
					end
				end

				arg_52_1.text_.text = var_55_11
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_10, arg_52_1.talkMaxDuration)

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_9) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_9 + var_55_14 and arg_52_1.time_ < var_55_9 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play325582014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325582014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play325582015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 1.35

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(325582014).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 54 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 54)

				if (54 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 54)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play325582015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325582015
		arg_60_1.duration_ = 7.8

		local var_60_0 = {
			zh = 4.866,
			ja = 7.8
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play325582016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos10175ui_story = arg_60_1.actors_["10175ui_story"].transform.localPosition

				local var_63_0 = GameObjectTools.GetOrAddComponent(arg_60_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_63_0 then
					var_63_0:EnableDynamicBone(false)
				end
			end

			local var_63_1 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_1 then
				arg_60_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_60_1.time_ - 0) / var_63_1)
				arg_60_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10175ui_story"].transform.position).z)
				arg_60_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["10175ui_story"].transform.localEulerAngles = arg_60_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_1 and arg_60_1.time_ < 0 + var_63_1 + arg_63_0 then
				arg_60_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_60_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10175ui_story"].transform.position).z)
				arg_60_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["10175ui_story"].transform.localEulerAngles = arg_60_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_63_2 = GameObjectTools.GetOrAddComponent(arg_60_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(true)
				end
			end

			local var_63_3 = arg_60_1.actors_["10175ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_3) and arg_60_1.var_.characterEffect10175ui_story == nil then
				arg_60_1.var_.characterEffect10175ui_story = var_63_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_4 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 and not isNil(var_63_3) then
				if arg_60_1.var_.characterEffect10175ui_story and not isNil(var_63_3) then
					arg_60_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 and not isNil(var_63_3) and arg_60_1.var_.characterEffect10175ui_story then
				arg_60_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_63_6 = 0
			local var_63_7 = 0.525

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_8 = arg_60_1:GetWordFromCfg(325582015)
				local var_63_9 = arg_60_1:FormatText(var_63_8.content)

				arg_60_1.text_.text = var_63_9

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 21 <= 0 and var_63_7 or var_63_7 * (utf8.len(var_63_9) / 21)

				if (21 <= 0 and var_63_7 or var_63_7 * (utf8.len(var_63_9) / 21)) > 0 and var_63_7 < var_63_11 then
					arg_60_1.talkMaxDuration = var_63_11

					if var_63_11 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_11 + var_63_6
					end
				end

				arg_60_1.text_.text = var_63_9
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582015", "story_v_out_325582.awb") ~= 0 then
					local var_63_12 = manager.audio:GetVoiceLength("story_v_out_325582", "325582015", "story_v_out_325582.awb") / 1000

					if var_63_12 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_12 + var_63_6
					end

					if var_63_8.prefab_name ~= "" and arg_60_1.actors_[var_63_8.prefab_name] ~= nil then
						local var_63_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_8.prefab_name].transform, "story_v_out_325582", "325582015", "story_v_out_325582.awb")

						arg_60_1:RecordAudio("325582015", var_63_13)
						arg_60_1:RecordAudio("325582015", var_63_13)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325582", "325582015", "story_v_out_325582.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325582", "325582015", "story_v_out_325582.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_14 and arg_60_1.time_ < var_63_6 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play325582016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325582016
		arg_64_1.duration_ = 2

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325582017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos10175ui_story = arg_64_1.actors_["10175ui_story"].transform.localPosition

				local var_67_0 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_0 then
					var_67_0:EnableDynamicBone(false)
				end
			end

			local var_67_1 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_1 then
				arg_64_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10175ui_story, Vector3.New(-0.7, -1, -6.05), (arg_64_1.time_ - 0) / var_67_1)
				arg_64_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10175ui_story"].transform.position).z)
				arg_64_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["10175ui_story"].transform.localEulerAngles = arg_64_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_1 and arg_64_1.time_ < 0 + var_67_1 + arg_67_0 then
				arg_64_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.05)
				arg_64_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10175ui_story"].transform.position).z)
				arg_64_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["10175ui_story"].transform.localEulerAngles = arg_64_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_67_2 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(true)
				end
			end

			local var_67_3 = arg_64_1.actors_["10166ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos10166ui_story = var_67_3.localPosition

				local var_67_4 = GameObjectTools.GetOrAddComponent(var_67_3.gameObject, typeof(DynamicBoneHelper))

				if var_67_4 then
					var_67_4:EnableDynamicBone(false)
				end
			end

			local var_67_5 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_5 then
				var_67_3.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10166ui_story, Vector3.New(0.7, -1.28, -5.73), (arg_64_1.time_ - 0) / var_67_5)
				var_67_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_3.position).x, (manager.ui.mainCamera.transform.position - var_67_3.position).y, (manager.ui.mainCamera.transform.position - var_67_3.position).z)
				var_67_3.localEulerAngles.z = 0
				var_67_3.localEulerAngles.x = 0
				var_67_3.localEulerAngles = var_67_3.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_5 and arg_64_1.time_ < 0 + var_67_5 + arg_67_0 then
				var_67_3.localPosition = Vector3.New(0.7, -1.28, -5.73)
				var_67_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_3.position).x, (manager.ui.mainCamera.transform.position - var_67_3.position).y, (manager.ui.mainCamera.transform.position - var_67_3.position).z)
				var_67_3.localEulerAngles.z = 0
				var_67_3.localEulerAngles.x = 0
				var_67_3.localEulerAngles = var_67_3.localEulerAngles

				local var_67_6 = GameObjectTools.GetOrAddComponent(var_67_3.gameObject, typeof(DynamicBoneHelper))

				if var_67_6 then
					var_67_6:EnableDynamicBone(true)
				end
			end

			local var_67_7 = arg_64_1.actors_["10166ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_7) and arg_64_1.var_.characterEffect10166ui_story == nil then
				arg_64_1.var_.characterEffect10166ui_story = var_67_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_8 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_8 and not isNil(var_67_7) then
				if arg_64_1.var_.characterEffect10166ui_story and not isNil(var_67_7) then
					arg_64_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_8 and arg_64_1.time_ < 0 + var_67_8 + arg_67_0 and not isNil(var_67_7) and arg_64_1.var_.characterEffect10166ui_story then
				arg_64_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_67_10 = arg_64_1.actors_["10175ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_10) and arg_64_1.var_.characterEffect10175ui_story == nil then
				arg_64_1.var_.characterEffect10175ui_story = var_67_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_11 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_11 and not isNil(var_67_10) then
				if arg_64_1.var_.characterEffect10175ui_story and not isNil(var_67_10) then
					arg_64_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_11)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_11 and arg_64_1.time_ < 0 + var_67_11 + arg_67_0 and not isNil(var_67_10) and arg_64_1.var_.characterEffect10175ui_story then
				arg_64_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_12 = 0
			local var_67_13 = 0.1

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_14 = arg_64_1:GetWordFromCfg(325582016)
				local var_67_15 = arg_64_1:FormatText(var_67_14.content)

				arg_64_1.text_.text = var_67_15

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_17 = 4 <= 0 and var_67_13 or var_67_13 * (utf8.len(var_67_15) / 4)

				if (4 <= 0 and var_67_13 or var_67_13 * (utf8.len(var_67_15) / 4)) > 0 and var_67_13 < var_67_17 then
					arg_64_1.talkMaxDuration = var_67_17

					if var_67_17 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_12
					end
				end

				arg_64_1.text_.text = var_67_15
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582016", "story_v_out_325582.awb") ~= 0 then
					local var_67_18 = manager.audio:GetVoiceLength("story_v_out_325582", "325582016", "story_v_out_325582.awb") / 1000

					if var_67_18 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_18 + var_67_12
					end

					if var_67_14.prefab_name ~= "" and arg_64_1.actors_[var_67_14.prefab_name] ~= nil then
						local var_67_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_14.prefab_name].transform, "story_v_out_325582", "325582016", "story_v_out_325582.awb")

						arg_64_1:RecordAudio("325582016", var_67_19)
						arg_64_1:RecordAudio("325582016", var_67_19)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325582", "325582016", "story_v_out_325582.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325582", "325582016", "story_v_out_325582.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_20 = math.max(var_67_13, arg_64_1.talkMaxDuration)

			if var_67_12 <= arg_64_1.time_ and arg_64_1.time_ < var_67_12 + var_67_20 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_12) / var_67_20

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_12 + var_67_20 and arg_64_1.time_ < var_67_12 + var_67_20 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play325582017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325582017
		arg_68_1.duration_ = 4.43

		local var_68_0 = {
			zh = 4.033,
			ja = 4.433
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play325582018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["10175ui_story"]) and arg_68_1.var_.characterEffect10175ui_story == nil then
				arg_68_1.var_.characterEffect10175ui_story = arg_68_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["10175ui_story"]) then
				if arg_68_1.var_.characterEffect10175ui_story and not isNil(arg_68_1.actors_["10175ui_story"]) then
					arg_68_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["10175ui_story"]) and arg_68_1.var_.characterEffect10175ui_story then
				arg_68_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_71_2 = arg_68_1.actors_["10166ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect10166ui_story == nil then
				arg_68_1.var_.characterEffect10166ui_story = var_71_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_3 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 and not isNil(var_71_2) then
				if arg_68_1.var_.characterEffect10166ui_story and not isNil(var_71_2) then
					arg_68_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_68_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_3)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect10166ui_story then
				arg_68_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_68_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_71_4 = 0
			local var_71_5 = 0.525

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(325582017)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 21 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 21)

				if (21 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 21)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582017", "story_v_out_325582.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_325582", "325582017", "story_v_out_325582.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_325582", "325582017", "story_v_out_325582.awb")

						arg_68_1:RecordAudio("325582017", var_71_11)
						arg_68_1:RecordAudio("325582017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_325582", "325582017", "story_v_out_325582.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_325582", "325582017", "story_v_out_325582.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_12 and arg_68_1.time_ < var_71_4 + var_71_12 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play325582018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325582018
		arg_72_1.duration_ = 7.87

		local var_72_0 = {
			zh = 4.466,
			ja = 7.866
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play325582019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_2")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_75_0 = 0
			local var_75_1 = 0.6

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(325582018)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 24 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 24)

				if (24 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 24)) > 0 and var_75_1 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582018", "story_v_out_325582.awb") ~= 0 then
					local var_75_6 = manager.audio:GetVoiceLength("story_v_out_325582", "325582018", "story_v_out_325582.awb") / 1000

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end

					if var_75_2.prefab_name ~= "" and arg_72_1.actors_[var_75_2.prefab_name] ~= nil then
						local var_75_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_2.prefab_name].transform, "story_v_out_325582", "325582018", "story_v_out_325582.awb")

						arg_72_1:RecordAudio("325582018", var_75_7)
						arg_72_1:RecordAudio("325582018", var_75_7)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325582", "325582018", "story_v_out_325582.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325582", "325582018", "story_v_out_325582.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_8 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_8 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_8

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_8 and arg_72_1.time_ < var_75_0 + var_75_8 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play325582019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325582019
		arg_76_1.duration_ = 5.23

		local var_76_0 = {
			zh = 4.133,
			ja = 5.233
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play325582020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos10166ui_story = arg_76_1.actors_["10166ui_story"].transform.localPosition

				local var_79_0 = GameObjectTools.GetOrAddComponent(arg_76_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_79_0 then
					var_79_0:EnableDynamicBone(false)
				end
			end

			local var_79_1 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_1 then
				arg_76_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10166ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 0) / var_79_1)
				arg_76_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10166ui_story"].transform.position).z)
				arg_76_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["10166ui_story"].transform.localEulerAngles = arg_76_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_1 and arg_76_1.time_ < 0 + var_79_1 + arg_79_0 then
				arg_76_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10166ui_story"].transform.position).z)
				arg_76_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["10166ui_story"].transform.localEulerAngles = arg_76_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_79_2 = GameObjectTools.GetOrAddComponent(arg_76_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_79_2 then
					var_79_2:EnableDynamicBone(true)
				end
			end

			local var_79_3 = "10162ui_story"

			if arg_76_1.actors_["10162ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10162ui_story"))) then
				local var_79_4 = Object.Instantiate(Asset.Load("Char/" .. "10162ui_story"), arg_76_1.stage_.transform)

				var_79_4.name = var_79_3
				var_79_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.actors_[var_79_3] = var_79_4

				local var_79_5 = var_79_4:GetComponentInChildren(typeof(CharacterEffect))

				var_79_5.enabled = true

				local var_79_6 = GameObjectTools.GetOrAddComponent(var_79_4, typeof(DynamicBoneHelper))

				if var_79_6 then
					var_79_6:EnableDynamicBone(false)
				end

				arg_76_1:ShowWeapon(var_79_5.transform, false)

				arg_76_1.var_[var_79_3 .. "Animator"] = var_79_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_76_1.var_[var_79_3 .. "Animator"].applyRootMotion = true
				arg_76_1.var_[var_79_3 .. "LipSync"] = var_79_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_79_7 = arg_76_1.actors_["10162ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos10162ui_story = var_79_7.localPosition

				local var_79_8 = GameObjectTools.GetOrAddComponent(var_79_7.gameObject, typeof(DynamicBoneHelper))

				if var_79_8 then
					var_79_8:EnableDynamicBone(false)
				end
			end

			local var_79_9 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_9 then
				var_79_7.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10162ui_story, Vector3.New(0, -1.08, -5.83), (arg_76_1.time_ - 0) / var_79_9)
				var_79_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_7.position).x, (manager.ui.mainCamera.transform.position - var_79_7.position).y, (manager.ui.mainCamera.transform.position - var_79_7.position).z)
				var_79_7.localEulerAngles.z = 0
				var_79_7.localEulerAngles.x = 0
				var_79_7.localEulerAngles = var_79_7.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_9 and arg_76_1.time_ < 0 + var_79_9 + arg_79_0 then
				var_79_7.localPosition = Vector3.New(0, -1.08, -5.83)
				var_79_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_7.position).x, (manager.ui.mainCamera.transform.position - var_79_7.position).y, (manager.ui.mainCamera.transform.position - var_79_7.position).z)
				var_79_7.localEulerAngles.z = 0
				var_79_7.localEulerAngles.x = 0
				var_79_7.localEulerAngles = var_79_7.localEulerAngles

				local var_79_10 = GameObjectTools.GetOrAddComponent(var_79_7.gameObject, typeof(DynamicBoneHelper))

				if var_79_10 then
					var_79_10:EnableDynamicBone(true)
				end
			end

			local var_79_11 = arg_76_1.actors_["10175ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos10175ui_story = var_79_11.localPosition

				local var_79_12 = GameObjectTools.GetOrAddComponent(var_79_11.gameObject, typeof(DynamicBoneHelper))

				if var_79_12 then
					var_79_12:EnableDynamicBone(false)
				end
			end

			local var_79_13 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_13 then
				var_79_11.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 0) / var_79_13)
				var_79_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_11.position).x, (manager.ui.mainCamera.transform.position - var_79_11.position).y, (manager.ui.mainCamera.transform.position - var_79_11.position).z)
				var_79_11.localEulerAngles.z = 0
				var_79_11.localEulerAngles.x = 0
				var_79_11.localEulerAngles = var_79_11.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_13 and arg_76_1.time_ < 0 + var_79_13 + arg_79_0 then
				var_79_11.localPosition = Vector3.New(0, 100, 0)
				var_79_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_11.position).x, (manager.ui.mainCamera.transform.position - var_79_11.position).y, (manager.ui.mainCamera.transform.position - var_79_11.position).z)
				var_79_11.localEulerAngles.z = 0
				var_79_11.localEulerAngles.x = 0
				var_79_11.localEulerAngles = var_79_11.localEulerAngles

				local var_79_14 = GameObjectTools.GetOrAddComponent(var_79_11.gameObject, typeof(DynamicBoneHelper))

				if var_79_14 then
					var_79_14:EnableDynamicBone(true)
				end
			end

			local var_79_15 = arg_76_1.actors_["10162ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_15) and arg_76_1.var_.characterEffect10162ui_story == nil then
				arg_76_1.var_.characterEffect10162ui_story = var_79_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_16 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_16 and not isNil(var_79_15) then
				if arg_76_1.var_.characterEffect10162ui_story and not isNil(var_79_15) then
					arg_76_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_16 and arg_76_1.time_ < 0 + var_79_16 + arg_79_0 and not isNil(var_79_15) and arg_76_1.var_.characterEffect10162ui_story then
				arg_76_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_79_18 = arg_76_1.actors_["10175ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_18) and arg_76_1.var_.characterEffect10175ui_story == nil then
				arg_76_1.var_.characterEffect10175ui_story = var_79_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_19 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_19 and not isNil(var_79_18) then
				if arg_76_1.var_.characterEffect10175ui_story and not isNil(var_79_18) then
					arg_76_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_76_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_19)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_19 and arg_76_1.time_ < 0 + var_79_19 + arg_79_0 and not isNil(var_79_18) and arg_76_1.var_.characterEffect10175ui_story then
				arg_76_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_76_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_20 = 0
			local var_79_21 = 0.375

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_20 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1533].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_22 = arg_76_1:GetWordFromCfg(325582019)
				local var_79_23 = arg_76_1:FormatText(var_79_22.content)

				arg_76_1.text_.text = var_79_23

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_25 = 15 <= 0 and var_79_21 or var_79_21 * (utf8.len(var_79_23) / 15)

				if (15 <= 0 and var_79_21 or var_79_21 * (utf8.len(var_79_23) / 15)) > 0 and var_79_21 < var_79_25 then
					arg_76_1.talkMaxDuration = var_79_25

					if var_79_25 + var_79_20 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_25 + var_79_20
					end
				end

				arg_76_1.text_.text = var_79_23
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582019", "story_v_out_325582.awb") ~= 0 then
					local var_79_26 = manager.audio:GetVoiceLength("story_v_out_325582", "325582019", "story_v_out_325582.awb") / 1000

					if var_79_26 + var_79_20 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_26 + var_79_20
					end

					if var_79_22.prefab_name ~= "" and arg_76_1.actors_[var_79_22.prefab_name] ~= nil then
						local var_79_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_22.prefab_name].transform, "story_v_out_325582", "325582019", "story_v_out_325582.awb")

						arg_76_1:RecordAudio("325582019", var_79_27)
						arg_76_1:RecordAudio("325582019", var_79_27)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325582", "325582019", "story_v_out_325582.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325582", "325582019", "story_v_out_325582.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_28 = math.max(var_79_21, arg_76_1.talkMaxDuration)

			if var_79_20 <= arg_76_1.time_ and arg_76_1.time_ < var_79_20 + var_79_28 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_20) / var_79_28

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_20 + var_79_28 and arg_76_1.time_ < var_79_20 + var_79_28 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play325582020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325582020
		arg_80_1.duration_ = 7.17

		local var_80_0 = {
			zh = 7.166,
			ja = 5.5
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play325582021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_83_0 = arg_80_1.actors_["10162ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10162ui_story == nil then
				arg_80_1.var_.characterEffect10162ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_1 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_1 and not isNil(var_83_0) then
				if arg_80_1.var_.characterEffect10162ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_80_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_1)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_1 and arg_80_1.time_ < 0 + var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10162ui_story then
				arg_80_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_80_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			local var_83_2 = 0
			local var_83_3 = 0.55

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_2 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1532].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_4 = arg_80_1:GetWordFromCfg(325582020)
				local var_83_5 = arg_80_1:FormatText(var_83_4.content)

				arg_80_1.text_.text = var_83_5

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_7 = 22 <= 0 and var_83_3 or var_83_3 * (utf8.len(var_83_5) / 22)

				if (22 <= 0 and var_83_3 or var_83_3 * (utf8.len(var_83_5) / 22)) > 0 and var_83_3 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_2
					end
				end

				arg_80_1.text_.text = var_83_5
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582020", "story_v_out_325582.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_325582", "325582020", "story_v_out_325582.awb") / 1000

					if var_83_8 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_2
					end

					if var_83_4.prefab_name ~= "" and arg_80_1.actors_[var_83_4.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_4.prefab_name].transform, "story_v_out_325582", "325582020", "story_v_out_325582.awb")

						arg_80_1:RecordAudio("325582020", var_83_9)
						arg_80_1:RecordAudio("325582020", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_325582", "325582020", "story_v_out_325582.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_325582", "325582020", "story_v_out_325582.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_3, arg_80_1.talkMaxDuration)

			if var_83_2 <= arg_80_1.time_ and arg_80_1.time_ < var_83_2 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_2) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_2 + var_83_10 and arg_80_1.time_ < var_83_2 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play325582021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325582021
		arg_84_1.duration_ = 4.8

		local var_84_0 = {
			zh = 4.433,
			ja = 4.8
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play325582022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["10162ui_story"]) and arg_84_1.var_.characterEffect10162ui_story == nil then
				arg_84_1.var_.characterEffect10162ui_story = arg_84_1.actors_["10162ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["10162ui_story"]) then
				if arg_84_1.var_.characterEffect10162ui_story and not isNil(arg_84_1.actors_["10162ui_story"]) then
					arg_84_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["10162ui_story"]) and arg_84_1.var_.characterEffect10162ui_story then
				arg_84_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_1")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_87_2 = 0
			local var_87_3 = 0.425

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1533].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:GetWordFromCfg(325582021)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 17 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 17)

				if (17 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 17)) > 0 and var_87_3 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582021", "story_v_out_325582.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_325582", "325582021", "story_v_out_325582.awb") / 1000

					if var_87_8 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_2
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_out_325582", "325582021", "story_v_out_325582.awb")

						arg_84_1:RecordAudio("325582021", var_87_9)
						arg_84_1:RecordAudio("325582021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_325582", "325582021", "story_v_out_325582.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_325582", "325582021", "story_v_out_325582.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_10 and arg_84_1.time_ < var_87_2 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play325582022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325582022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play325582023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos10162ui_story = arg_88_1.actors_["10162ui_story"].transform.localPosition

				local var_91_0 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_0 then
					var_91_0:EnableDynamicBone(false)
				end
			end

			local var_91_1 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_1 then
				arg_88_1.actors_["10162ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10162ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_1)
				arg_88_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["10162ui_story"].transform.position).z)
				arg_88_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["10162ui_story"].transform.localEulerAngles = arg_88_1.actors_["10162ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_1 and arg_88_1.time_ < 0 + var_91_1 + arg_91_0 then
				arg_88_1.actors_["10162ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["10162ui_story"].transform.position).z)
				arg_88_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["10162ui_story"].transform.localEulerAngles = arg_88_1.actors_["10162ui_story"].transform.localEulerAngles

				local var_91_2 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(true)
				end
			end

			local var_91_3 = arg_88_1.actors_["10162ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_3) and arg_88_1.var_.characterEffect10162ui_story == nil then
				arg_88_1.var_.characterEffect10162ui_story = var_91_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_4 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 and not isNil(var_91_3) then
				if arg_88_1.var_.characterEffect10162ui_story and not isNil(var_91_3) then
					arg_88_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_88_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_4)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 and not isNil(var_91_3) and arg_88_1.var_.characterEffect10162ui_story then
				arg_88_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_88_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			local var_91_5 = 0
			local var_91_6 = 1.6

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_7 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(325582022).content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 64 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_7) / 64)

				if (64 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_7) / 64)) > 0 and var_91_6 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_5
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_6, arg_88_1.talkMaxDuration)

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_5) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_5 + var_91_10 and arg_88_1.time_ < var_91_5 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play325582023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325582023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play325582024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story_15", "se_story_15_roar3", "")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_95_2 = 0
			local var_95_3 = 1.175

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_4 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(325582023).content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_6 = 47 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_4) / 47)

				if (47 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_4) / 47)) > 0 and var_95_3 < var_95_6 then
					arg_92_1.talkMaxDuration = var_95_6

					if var_95_6 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_2
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_3, arg_92_1.talkMaxDuration)

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_2) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_2 + var_95_7 and arg_92_1.time_ < var_95_2 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play325582024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325582024
		arg_96_1.duration_ = 2

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play325582025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos10175ui_story = arg_96_1.actors_["10175ui_story"].transform.localPosition

				local var_99_0 = GameObjectTools.GetOrAddComponent(arg_96_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_99_0 then
					var_99_0:EnableDynamicBone(false)
				end
			end

			local var_99_1 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_1 then
				arg_96_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_96_1.time_ - 0) / var_99_1)
				arg_96_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10175ui_story"].transform.position).z)
				arg_96_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["10175ui_story"].transform.localEulerAngles = arg_96_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_1 and arg_96_1.time_ < 0 + var_99_1 + arg_99_0 then
				arg_96_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_96_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["10175ui_story"].transform.position).z)
				arg_96_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["10175ui_story"].transform.localEulerAngles = arg_96_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_99_2 = GameObjectTools.GetOrAddComponent(arg_96_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(true)
				end
			end

			local var_99_3 = arg_96_1.actors_["10175ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_3) and arg_96_1.var_.characterEffect10175ui_story == nil then
				arg_96_1.var_.characterEffect10175ui_story = var_99_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_4 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 and not isNil(var_99_3) then
				if arg_96_1.var_.characterEffect10175ui_story and not isNil(var_99_3) then
					arg_96_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 and not isNil(var_99_3) and arg_96_1.var_.characterEffect10175ui_story then
				arg_96_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaB", "EmotionTimelineAnimator")
			end

			local var_99_6 = 0
			local var_99_7 = 0.125

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_8 = arg_96_1:GetWordFromCfg(325582024)
				local var_99_9 = arg_96_1:FormatText(var_99_8.content)

				arg_96_1.text_.text = var_99_9

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 5 <= 0 and var_99_7 or var_99_7 * (utf8.len(var_99_9) / 5)

				if (5 <= 0 and var_99_7 or var_99_7 * (utf8.len(var_99_9) / 5)) > 0 and var_99_7 < var_99_11 then
					arg_96_1.talkMaxDuration = var_99_11

					if var_99_11 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_11 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_9
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582024", "story_v_out_325582.awb") ~= 0 then
					local var_99_12 = manager.audio:GetVoiceLength("story_v_out_325582", "325582024", "story_v_out_325582.awb") / 1000

					if var_99_12 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_12 + var_99_6
					end

					if var_99_8.prefab_name ~= "" and arg_96_1.actors_[var_99_8.prefab_name] ~= nil then
						local var_99_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_8.prefab_name].transform, "story_v_out_325582", "325582024", "story_v_out_325582.awb")

						arg_96_1:RecordAudio("325582024", var_99_13)
						arg_96_1:RecordAudio("325582024", var_99_13)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_325582", "325582024", "story_v_out_325582.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_325582", "325582024", "story_v_out_325582.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_14 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_14 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_14

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_14 and arg_96_1.time_ < var_99_6 + var_99_14 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play325582025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325582025
		arg_100_1.duration_ = 5.2

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play325582026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_9000

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos10175ui_story = arg_100_1.actors_["10175ui_story"].transform.localPosition

				local var_103_0 = GameObjectTools.GetOrAddComponent(arg_100_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_103_0 then
					var_103_0:EnableDynamicBone(false)
				end
			end

			local var_103_1 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_1 then
				arg_100_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_1)
				arg_100_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["10175ui_story"].transform.position).z)
				arg_100_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["10175ui_story"].transform.localEulerAngles = arg_100_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_1 and arg_100_1.time_ < 0 + var_103_1 + arg_103_0 then
				arg_100_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["10175ui_story"].transform.position).z)
				arg_100_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["10175ui_story"].transform.localEulerAngles = arg_100_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_103_2 = GameObjectTools.GetOrAddComponent(arg_100_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(true)
				end
			end

			local var_103_3 = arg_100_1.actors_["10175ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_3) and arg_100_1.var_.characterEffect10175ui_story == nil then
				arg_100_1.var_.characterEffect10175ui_story = var_103_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_4 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 and not isNil(var_103_3) then
				if arg_100_1.var_.characterEffect10175ui_story and not isNil(var_103_3) then
					arg_100_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_100_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_4)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 and not isNil(var_103_3) and arg_100_1.var_.characterEffect10175ui_story then
				arg_100_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_100_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_103_5 = arg_100_1.bgs_.J26h.transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPosJ26h = var_103_5.localPosition
			end

			local var_103_6 = 1.13333333333333

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_6 then
				var_103_5.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPosJ26h, Vector3.New(0, 1, 9), (arg_100_1.time_ - 0) / var_103_6)
			end

			if arg_100_1.time_ >= 0 + var_103_6 and arg_100_1.time_ < 0 + var_103_6 + arg_103_0 then
				var_103_5.localPosition = Vector3.New(0, 1, 9)
			end

			if 0.200000002980232 < arg_100_1.time_ and arg_100_1.time_ <= 0.200000002980232 + arg_103_0 then
				local var_103_7 = arg_100_1.var_.effectqiongqixilai1

				if not arg_100_1.var_.effectqiongqixilai1 then
					var_103_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), manager.ui.mainCamera.transform)
					var_103_7.name = "qiongqixilai1"
					arg_100_1.var_.effectqiongqixilai1 = var_103_7
				else
					var_103_7.transform:SetParent(var_103_9000)
				end

				var_103_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_103_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_103_9 = 0

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_9 + arg_103_0 then
				arg_100_1.allBtn_.enabled = false
			end

			if arg_100_1.time_ >= var_103_9 + 1.13333333333333 and arg_100_1.time_ < var_103_9 + 1.13333333333333 + arg_103_0 then
				arg_100_1.allBtn_.enabled = true
			end

			if 1 < arg_100_1.time_ and arg_100_1.time_ <= 1 + arg_103_0 then
				arg_100_1:AudioAction("play", "effect", "se_story_145", "se_story_145_monster_roar1", "")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_103_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_100_1.bgmTxt_.text ~= var_103_13 and arg_100_1.bgmTxt_.text ~= "" then
						if arg_100_1.bgmTxt2_.text ~= "" then
							arg_100_1.bgmTxt_.text = arg_100_1.bgmTxt2_.text
						end

						arg_100_1.bgmTxt2_.text = var_103_13

						arg_100_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_100_1.bgmTxt_.text = var_103_13
						arg_100_1.bgmTxt2_.text = var_103_13
					end

					if arg_100_1.bgmTimer then
						arg_100_1.bgmTimer:Stop()

						arg_100_1.bgmTimer = nil
					end

					if arg_100_1.settingData.show_music_name == 1 then
						arg_100_1.musicController:SetSelectedState("show")
						arg_100_1.musicAnimator_:Play("open", 0, 0)

						if arg_100_1.settingData.music_time ~= 0 then
							arg_100_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_100_1.settingData.music_time), function()
								if arg_100_1 == nil or isNil(arg_100_1.bgmTxt_) then
									return
								end

								arg_100_1.musicController:SetSelectedState("hide")
								arg_100_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_100_1.frameCnt_ <= 1 then
				arg_100_1.dialog_:SetActive(false)
			end

			local var_103_14 = 0.2
			local var_103_15 = 0.075

			if 0.2 < arg_100_1.time_ and arg_100_1.time_ <= var_103_14 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0

				arg_100_1.dialog_:SetActive(true)

				arg_100_1.dialogCg_.alpha = 0

				local var_103_16 = LeanTween.value(arg_100_1.dialog_, 0, 1, 0.3)

				var_103_16:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_100_1.dialogCg_.alpha = arg_105_0
				end))
				var_103_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_100_1.dialog_)
					var_103_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_100_1.duration_ = arg_100_1.duration_ + 0.3

				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1534].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4053")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_17 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(325582025).content)

				arg_100_1.text_.text = var_103_17

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_19 = 3 <= 0 and var_103_15 or var_103_15 * (utf8.len(var_103_17) / 3)

				if (3 <= 0 and var_103_15 or var_103_15 * (utf8.len(var_103_17) / 3)) > 0 and var_103_15 < var_103_19 then
					arg_100_1.talkMaxDuration = var_103_19
					var_103_14 = var_103_14 + 0.3

					if var_103_19 + var_103_14 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_19 + var_103_14
					end
				end

				arg_100_1.text_.text = var_103_17
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_20 = var_103_14 + 0.3
			local var_103_21 = math.max(var_103_15, arg_100_1.talkMaxDuration)

			if var_103_14 + 0.3 <= arg_100_1.time_ and arg_100_1.time_ < var_103_20 + var_103_21 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_20) / var_103_21

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_20 + var_103_21 and arg_100_1.time_ < var_103_20 + var_103_21 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "J26h",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.13333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play325582026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 325582026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play325582027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 1 < arg_107_1.time_ and arg_107_1.time_ <= 1 + arg_110_0 then
				arg_107_1:AudioAction("play", "effect", "se_story_15", "se_story_15_blast03", "")
			end

			local var_110_1 = 0
			local var_110_2 = 1.625

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(325582026).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 65 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 65)

				if (65 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 65)) > 0 and var_110_2 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_6 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_6 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_6

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_6 and arg_107_1.time_ < var_110_1 + var_110_6 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play325582027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 325582027
		arg_111_1.duration_ = 3.43

		local var_111_0 = {
			zh = 2.566,
			ja = 3.433
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play325582028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10175ui_story = arg_111_1.actors_["10175ui_story"].transform.localPosition

				local var_114_0 = GameObjectTools.GetOrAddComponent(arg_111_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_114_0 then
					var_114_0:EnableDynamicBone(false)
				end
			end

			local var_114_1 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				arg_111_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_111_1.time_ - 0) / var_114_1)
				arg_111_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10175ui_story"].transform.position).z)
				arg_111_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["10175ui_story"].transform.localEulerAngles = arg_111_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				arg_111_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_111_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10175ui_story"].transform.position).z)
				arg_111_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["10175ui_story"].transform.localEulerAngles = arg_111_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_114_2 = GameObjectTools.GetOrAddComponent(arg_111_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_114_2 then
					var_114_2:EnableDynamicBone(true)
				end
			end

			local var_114_3 = arg_111_1.actors_["10175ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_3) and arg_111_1.var_.characterEffect10175ui_story == nil then
				arg_111_1.var_.characterEffect10175ui_story = var_114_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_4 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 and not isNil(var_114_3) then
				if arg_111_1.var_.characterEffect10175ui_story and not isNil(var_114_3) then
					arg_111_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 and not isNil(var_114_3) and arg_111_1.var_.characterEffect10175ui_story then
				arg_111_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_114_6 = 0
			local var_114_7 = 0.3

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_8 = arg_111_1:GetWordFromCfg(325582027)
				local var_114_9 = arg_111_1:FormatText(var_114_8.content)

				arg_111_1.text_.text = var_114_9

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 12 <= 0 and var_114_7 or var_114_7 * (utf8.len(var_114_9) / 12)

				if (12 <= 0 and var_114_7 or var_114_7 * (utf8.len(var_114_9) / 12)) > 0 and var_114_7 < var_114_11 then
					arg_111_1.talkMaxDuration = var_114_11

					if var_114_11 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_9
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582027", "story_v_out_325582.awb") ~= 0 then
					local var_114_12 = manager.audio:GetVoiceLength("story_v_out_325582", "325582027", "story_v_out_325582.awb") / 1000

					if var_114_12 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_12 + var_114_6
					end

					if var_114_8.prefab_name ~= "" and arg_111_1.actors_[var_114_8.prefab_name] ~= nil then
						local var_114_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_8.prefab_name].transform, "story_v_out_325582", "325582027", "story_v_out_325582.awb")

						arg_111_1:RecordAudio("325582027", var_114_13)
						arg_111_1:RecordAudio("325582027", var_114_13)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_325582", "325582027", "story_v_out_325582.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_325582", "325582027", "story_v_out_325582.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_14 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_14 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_14

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_14 and arg_111_1.time_ < var_114_6 + var_114_14 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play325582028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 325582028
		arg_115_1.duration_ = 7.13

		local var_115_0 = {
			zh = 3.9,
			ja = 7.133
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play325582029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action38_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_118_0 = 0
			local var_118_1 = 0.4

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_2 = arg_115_1:GetWordFromCfg(325582028)
				local var_118_3 = arg_115_1:FormatText(var_118_2.content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 16 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_3) / 16)

				if (16 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_3) / 16)) > 0 and var_118_1 < var_118_5 then
					arg_115_1.talkMaxDuration = var_118_5

					if var_118_5 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582028", "story_v_out_325582.awb") ~= 0 then
					local var_118_6 = manager.audio:GetVoiceLength("story_v_out_325582", "325582028", "story_v_out_325582.awb") / 1000

					if var_118_6 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_0
					end

					if var_118_2.prefab_name ~= "" and arg_115_1.actors_[var_118_2.prefab_name] ~= nil then
						local var_118_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_2.prefab_name].transform, "story_v_out_325582", "325582028", "story_v_out_325582.awb")

						arg_115_1:RecordAudio("325582028", var_118_7)
						arg_115_1:RecordAudio("325582028", var_118_7)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_325582", "325582028", "story_v_out_325582.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_325582", "325582028", "story_v_out_325582.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_8 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_8 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_8

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_8 and arg_115_1.time_ < var_118_0 + var_118_8 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play325582029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 325582029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play325582030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10175ui_story = arg_119_1.actors_["10175ui_story"].transform.localPosition

				local var_122_0 = GameObjectTools.GetOrAddComponent(arg_119_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_122_0 then
					var_122_0:EnableDynamicBone(false)
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_1)
				arg_119_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10175ui_story"].transform.position).z)
				arg_119_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10175ui_story"].transform.localEulerAngles = arg_119_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10175ui_story"].transform.position).z)
				arg_119_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10175ui_story"].transform.localEulerAngles = arg_119_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_122_2 = GameObjectTools.GetOrAddComponent(arg_119_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_122_2 then
					var_122_2:EnableDynamicBone(true)
				end
			end

			local var_122_3 = arg_119_1.actors_["10175ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_3) and arg_119_1.var_.characterEffect10175ui_story == nil then
				arg_119_1.var_.characterEffect10175ui_story = var_122_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_4 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 and not isNil(var_122_3) then
				if arg_119_1.var_.characterEffect10175ui_story and not isNil(var_122_3) then
					arg_119_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_4)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 and not isNil(var_122_3) and arg_119_1.var_.characterEffect10175ui_story then
				arg_119_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_122_5 = 0
			local var_122_6 = 1.2

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(325582029).content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 48 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_7) / 48)

				if (48 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_7) / 48)) > 0 and var_122_6 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_6, arg_119_1.talkMaxDuration)

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_5) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_5 + var_122_10 and arg_119_1.time_ < var_122_5 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play325582030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 325582030
		arg_123_1.duration_ = 6.07

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play325582031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				local var_126_0 = arg_123_1.var_.effectdaoguang12342

				if not arg_123_1.var_.effectdaoguang12342 then
					var_126_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_126_0.name = "daoguang12342"
					arg_123_1.var_.effectdaoguang12342 = var_126_0
				else
					var_126_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_126_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_126_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_123_1.time_ and arg_123_1.time_ <= 2 + arg_126_0 then
				if arg_123_1.var_.effectdaoguang12342 then
					Object.Destroy(arg_123_1.var_.effectdaoguang12342)

					arg_123_1.var_.effectdaoguang12342 = nil
				end
			end

			local var_126_3 = 0

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_3 + arg_126_0 then
				arg_123_1.allBtn_.enabled = false
			end

			if arg_123_1.time_ >= var_126_3 + 2.15833333333333 and arg_123_1.time_ < var_126_3 + 2.15833333333333 + arg_126_0 then
				arg_123_1.allBtn_.enabled = true
			end

			local var_126_4 = manager.ui.mainCamera.transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.shakeOldPos = var_126_4.localPosition
			end

			local var_126_5 = 0.833333333333333

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_5 then
				local var_126_6, var_126_7 = math.modf((arg_123_1.time_ - 0) / 0.066)

				var_126_4.localPosition = Vector3.New(var_126_7 * 0.13, var_126_7 * 0.13, var_126_7 * 0.13) + arg_123_1.var_.shakeOldPos
			end

			if arg_123_1.time_ >= 0 + var_126_5 and arg_123_1.time_ < 0 + var_126_5 + arg_126_0 then
				var_126_4.localPosition = arg_123_1.var_.shakeOldPos
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_8 = 1.06666666666667
			local var_126_9 = 1.625

			if 1.06666666666667 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_10 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_10:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_11 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(325582030).content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 65 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 65)

				if (65 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 65)) > 0 and var_126_9 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13
					var_126_8 = var_126_8 + 0.3

					if var_126_13 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_14 = var_126_8 + 0.3
			local var_126_15 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 + 0.3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_14 + var_126_15 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_14) / var_126_15

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_14 + var_126_15 and arg_123_1.time_ < var_126_14 + var_126_15 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play325582031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 325582031
		arg_129_1.duration_ = 4.63

		local var_129_0 = {
			zh = 3.666,
			ja = 4.633
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play325582032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10175ui_story = arg_129_1.actors_["10175ui_story"].transform.localPosition

				local var_132_0 = GameObjectTools.GetOrAddComponent(arg_129_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_132_0 then
					var_132_0:EnableDynamicBone(false)
				end
			end

			local var_132_1 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_1 then
				arg_129_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_129_1.time_ - 0) / var_132_1)
				arg_129_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10175ui_story"].transform.position).z)
				arg_129_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10175ui_story"].transform.localEulerAngles = arg_129_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_1 and arg_129_1.time_ < 0 + var_132_1 + arg_132_0 then
				arg_129_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_129_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10175ui_story"].transform.position).z)
				arg_129_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10175ui_story"].transform.localEulerAngles = arg_129_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_132_2 = GameObjectTools.GetOrAddComponent(arg_129_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_132_2 then
					var_132_2:EnableDynamicBone(true)
				end
			end

			local var_132_3 = arg_129_1.actors_["10175ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_3) and arg_129_1.var_.characterEffect10175ui_story == nil then
				arg_129_1.var_.characterEffect10175ui_story = var_132_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_4 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 and not isNil(var_132_3) then
				if arg_129_1.var_.characterEffect10175ui_story and not isNil(var_132_3) then
					arg_129_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 and not isNil(var_132_3) and arg_129_1.var_.characterEffect10175ui_story then
				arg_129_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_132_6 = 0
			local var_132_7 = 0.375

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(325582031)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 15 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 15)

				if (15 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 15)) > 0 and var_132_7 < var_132_11 then
					arg_129_1.talkMaxDuration = var_132_11

					if var_132_11 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582031", "story_v_out_325582.awb") ~= 0 then
					local var_132_12 = manager.audio:GetVoiceLength("story_v_out_325582", "325582031", "story_v_out_325582.awb") / 1000

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end

					if var_132_8.prefab_name ~= "" and arg_129_1.actors_[var_132_8.prefab_name] ~= nil then
						local var_132_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_8.prefab_name].transform, "story_v_out_325582", "325582031", "story_v_out_325582.awb")

						arg_129_1:RecordAudio("325582031", var_132_13)
						arg_129_1:RecordAudio("325582031", var_132_13)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_325582", "325582031", "story_v_out_325582.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_325582", "325582031", "story_v_out_325582.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play325582032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 325582032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play325582033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10175ui_story = arg_133_1.actors_["10175ui_story"].transform.localPosition

				local var_136_0 = GameObjectTools.GetOrAddComponent(arg_133_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_136_0 then
					var_136_0:EnableDynamicBone(false)
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_1)
				arg_133_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10175ui_story"].transform.position).z)
				arg_133_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10175ui_story"].transform.localEulerAngles = arg_133_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10175ui_story"].transform.position).z)
				arg_133_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10175ui_story"].transform.localEulerAngles = arg_133_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_136_2 = GameObjectTools.GetOrAddComponent(arg_133_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(true)
				end
			end

			local var_136_3 = arg_133_1.actors_["10175ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_3) and arg_133_1.var_.characterEffect10175ui_story == nil then
				arg_133_1.var_.characterEffect10175ui_story = var_136_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_4 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 and not isNil(var_136_3) then
				if arg_133_1.var_.characterEffect10175ui_story and not isNil(var_136_3) then
					arg_133_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_4)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 and not isNil(var_136_3) and arg_133_1.var_.characterEffect10175ui_story then
				arg_133_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_136_5 = 0
			local var_136_6 = 1.55

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_7 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(325582032).content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 62 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_7) / 62)

				if (62 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_7) / 62)) > 0 and var_136_6 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_5
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_6, arg_133_1.talkMaxDuration)

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_5) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_5 + var_136_10 and arg_133_1.time_ < var_136_5 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play325582033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 325582033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play325582034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0.1 < arg_137_1.time_ and arg_137_1.time_ <= 0.1 + arg_140_0 then
				arg_137_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_magic", "")
			end

			local var_140_1 = 0
			local var_140_2 = 1.075

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(325582033).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 43 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 43)

				if (43 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 43)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play325582034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 325582034
		arg_141_1.duration_ = 5.37

		local var_141_0 = {
			zh = 5.366,
			ja = 4.8
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play325582035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10175ui_story = arg_141_1.actors_["10175ui_story"].transform.localPosition

				local var_144_0 = GameObjectTools.GetOrAddComponent(arg_141_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_144_0 then
					var_144_0:EnableDynamicBone(false)
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_141_1.time_ - 0) / var_144_1)
				arg_141_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10175ui_story"].transform.position).z)
				arg_141_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10175ui_story"].transform.localEulerAngles = arg_141_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_141_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10175ui_story"].transform.position).z)
				arg_141_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10175ui_story"].transform.localEulerAngles = arg_141_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_144_2 = GameObjectTools.GetOrAddComponent(arg_141_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_144_2 then
					var_144_2:EnableDynamicBone(true)
				end
			end

			local var_144_3 = arg_141_1.actors_["10175ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect10175ui_story == nil then
				arg_141_1.var_.characterEffect10175ui_story = var_144_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_4 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 and not isNil(var_144_3) then
				if arg_141_1.var_.characterEffect10175ui_story and not isNil(var_144_3) then
					arg_141_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect10175ui_story then
				arg_141_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_144_6 = 0
			local var_144_7 = 0.525

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_8 = arg_141_1:GetWordFromCfg(325582034)
				local var_144_9 = arg_141_1:FormatText(var_144_8.content)

				arg_141_1.text_.text = var_144_9

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 21 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 21)

				if (21 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 21)) > 0 and var_144_7 < var_144_11 then
					arg_141_1.talkMaxDuration = var_144_11

					if var_144_11 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_9
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582034", "story_v_out_325582.awb") ~= 0 then
					local var_144_12 = manager.audio:GetVoiceLength("story_v_out_325582", "325582034", "story_v_out_325582.awb") / 1000

					if var_144_12 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_6
					end

					if var_144_8.prefab_name ~= "" and arg_141_1.actors_[var_144_8.prefab_name] ~= nil then
						local var_144_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_8.prefab_name].transform, "story_v_out_325582", "325582034", "story_v_out_325582.awb")

						arg_141_1:RecordAudio("325582034", var_144_13)
						arg_141_1:RecordAudio("325582034", var_144_13)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_325582", "325582034", "story_v_out_325582.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_325582", "325582034", "story_v_out_325582.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_14 and arg_141_1.time_ < var_144_6 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play325582035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 325582035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play325582036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10175ui_story = arg_145_1.actors_["10175ui_story"].transform.localPosition

				local var_148_0 = GameObjectTools.GetOrAddComponent(arg_145_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_148_0 then
					var_148_0:EnableDynamicBone(false)
				end
			end

			local var_148_1 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 then
				arg_145_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_1)
				arg_145_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10175ui_story"].transform.position).z)
				arg_145_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10175ui_story"].transform.localEulerAngles = arg_145_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 then
				arg_145_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10175ui_story"].transform.position).z)
				arg_145_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10175ui_story"].transform.localEulerAngles = arg_145_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_148_2 = GameObjectTools.GetOrAddComponent(arg_145_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_148_2 then
					var_148_2:EnableDynamicBone(true)
				end
			end

			local var_148_3 = arg_145_1.actors_["10175ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_3) and arg_145_1.var_.characterEffect10175ui_story == nil then
				arg_145_1.var_.characterEffect10175ui_story = var_148_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_4 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 and not isNil(var_148_3) then
				if arg_145_1.var_.characterEffect10175ui_story and not isNil(var_148_3) then
					arg_145_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_4)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 and not isNil(var_148_3) and arg_145_1.var_.characterEffect10175ui_story then
				arg_145_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_148_5 = 0
			local var_148_6 = 1

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_7 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(325582035).content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 40 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_7) / 40)

				if (40 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_7) / 40)) > 0 and var_148_6 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_5
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_6, arg_145_1.talkMaxDuration)

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_5) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_5 + var_148_10 and arg_145_1.time_ < var_148_5 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play325582036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 325582036
		arg_149_1.duration_ = 6.53

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play325582037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				local var_152_0 = arg_149_1.var_.effectheibaishan213213

				if not arg_149_1.var_.effectheibaishan213213 then
					var_152_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_152_0.name = "heibaishan213213"
					arg_149_1.var_.effectheibaishan213213 = var_152_0
				else
					var_152_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_152_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_152_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_152_2 = 0

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.allBtn_.enabled = false
			end

			if arg_149_1.time_ >= var_152_2 + 1.999999999999 and arg_149_1.time_ < var_152_2 + 1.999999999999 + arg_152_0 then
				arg_149_1.allBtn_.enabled = true
			end

			if 0.1 < arg_149_1.time_ and arg_149_1.time_ <= 0.1 + arg_152_0 then
				arg_149_1:AudioAction("play", "effect", "se_story_150", "se_story_150_sword07", "")
			end

			if arg_149_1.frameCnt_ <= 1 then
				arg_149_1.dialog_:SetActive(false)
			end

			local var_152_4 = 1.53333333333333
			local var_152_5 = 1.85

			if 1.53333333333333 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				arg_149_1.dialog_:SetActive(true)

				arg_149_1.dialogCg_.alpha = 0

				local var_152_6 = LeanTween.value(arg_149_1.dialog_, 0, 1, 0.3)

				var_152_6:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_149_1.dialogCg_.alpha = arg_153_0
				end))
				var_152_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_149_1.dialog_)
					var_152_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_149_1.duration_ = arg_149_1.duration_ + 0.3

				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_7 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(325582036).content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 74 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 74)

				if (74 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 74)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9
					var_152_4 = var_152_4 + 0.3

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = var_152_4 + 0.3
			local var_152_11 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 + 0.3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_10) / var_152_11

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play325582037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 325582037
		arg_155_1.duration_ = 3.3

		local var_155_0 = {
			zh = 2.766,
			ja = 3.3
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play325582038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10175ui_story = arg_155_1.actors_["10175ui_story"].transform.localPosition

				local var_158_0 = GameObjectTools.GetOrAddComponent(arg_155_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_158_0 then
					var_158_0:EnableDynamicBone(false)
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_155_1.time_ - 0) / var_158_1)
				arg_155_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10175ui_story"].transform.position).z)
				arg_155_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10175ui_story"].transform.localEulerAngles = arg_155_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_155_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10175ui_story"].transform.position).z)
				arg_155_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10175ui_story"].transform.localEulerAngles = arg_155_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_158_2 = GameObjectTools.GetOrAddComponent(arg_155_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_158_2 then
					var_158_2:EnableDynamicBone(true)
				end
			end

			local var_158_3 = arg_155_1.actors_["10175ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_3) and arg_155_1.var_.characterEffect10175ui_story == nil then
				arg_155_1.var_.characterEffect10175ui_story = var_158_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_4 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 and not isNil(var_158_3) then
				if arg_155_1.var_.characterEffect10175ui_story and not isNil(var_158_3) then
					arg_155_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 and not isNil(var_158_3) and arg_155_1.var_.characterEffect10175ui_story then
				arg_155_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaB", "EmotionTimelineAnimator")
			end

			local var_158_6 = 0
			local var_158_7 = 0.225

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_8 = arg_155_1:GetWordFromCfg(325582037)
				local var_158_9 = arg_155_1:FormatText(var_158_8.content)

				arg_155_1.text_.text = var_158_9

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 9 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 9)

				if (9 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 9)) > 0 and var_158_7 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_9
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582037", "story_v_out_325582.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_325582", "325582037", "story_v_out_325582.awb") / 1000

					if var_158_12 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_6
					end

					if var_158_8.prefab_name ~= "" and arg_155_1.actors_[var_158_8.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_8.prefab_name].transform, "story_v_out_325582", "325582037", "story_v_out_325582.awb")

						arg_155_1:RecordAudio("325582037", var_158_13)
						arg_155_1:RecordAudio("325582037", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_325582", "325582037", "story_v_out_325582.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_325582", "325582037", "story_v_out_325582.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play325582038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 325582038
		arg_159_1.duration_ = 6

		local var_159_0 = {
			zh = 5.2,
			ja = 6
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
			arg_159_1.auto_ = false
		end

		function arg_159_1.playNext_(arg_161_0)
			arg_159_1.onStoryFinished_()
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10175ui_story = arg_159_1.actors_["10175ui_story"].transform.localPosition

				local var_162_0 = GameObjectTools.GetOrAddComponent(arg_159_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_162_0 then
					var_162_0:EnableDynamicBone(false)
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0) / var_162_1)
				arg_159_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10175ui_story"].transform.position).z)
				arg_159_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10175ui_story"].transform.localEulerAngles = arg_159_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10175ui_story"].transform.position).z)
				arg_159_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10175ui_story"].transform.localEulerAngles = arg_159_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_162_2 = GameObjectTools.GetOrAddComponent(arg_159_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_162_2 then
					var_162_2:EnableDynamicBone(true)
				end
			end

			local var_162_3 = "1054ui_story"

			if arg_159_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_162_4 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_159_1.stage_.transform)

				var_162_4.name = var_162_3
				var_162_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.actors_[var_162_3] = var_162_4

				local var_162_5 = var_162_4:GetComponentInChildren(typeof(CharacterEffect))

				var_162_5.enabled = true

				local var_162_6 = GameObjectTools.GetOrAddComponent(var_162_4, typeof(DynamicBoneHelper))

				if var_162_6 then
					var_162_6:EnableDynamicBone(false)
				end

				arg_159_1:ShowWeapon(var_162_5.transform, false)

				arg_159_1.var_[var_162_3 .. "Animator"] = var_162_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_159_1.var_[var_162_3 .. "Animator"].applyRootMotion = true
				arg_159_1.var_[var_162_3 .. "LipSync"] = var_162_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_162_7 = arg_159_1.actors_["1054ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1054ui_story = var_162_7.localPosition

				local var_162_8 = GameObjectTools.GetOrAddComponent(var_162_7.gameObject, typeof(DynamicBoneHelper))

				if var_162_8 then
					var_162_8:EnableDynamicBone(false)
				end
			end

			local var_162_9 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_9 then
				var_162_7.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_159_1.time_ - 0) / var_162_9)
				var_162_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_7.position).x, (manager.ui.mainCamera.transform.position - var_162_7.position).y, (manager.ui.mainCamera.transform.position - var_162_7.position).z)
				var_162_7.localEulerAngles.z = 0
				var_162_7.localEulerAngles.x = 0
				var_162_7.localEulerAngles = var_162_7.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_9 and arg_159_1.time_ < 0 + var_162_9 + arg_162_0 then
				var_162_7.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_162_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_7.position).x, (manager.ui.mainCamera.transform.position - var_162_7.position).y, (manager.ui.mainCamera.transform.position - var_162_7.position).z)
				var_162_7.localEulerAngles.z = 0
				var_162_7.localEulerAngles.x = 0
				var_162_7.localEulerAngles = var_162_7.localEulerAngles

				local var_162_10 = GameObjectTools.GetOrAddComponent(var_162_7.gameObject, typeof(DynamicBoneHelper))

				if var_162_10 then
					var_162_10:EnableDynamicBone(true)
				end
			end

			local var_162_11 = "6148ui_story"

			if arg_159_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_162_12 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_159_1.stage_.transform)

				var_162_12.name = var_162_11
				var_162_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.actors_[var_162_11] = var_162_12

				local var_162_13 = var_162_12:GetComponentInChildren(typeof(CharacterEffect))

				var_162_13.enabled = true

				local var_162_14 = GameObjectTools.GetOrAddComponent(var_162_12, typeof(DynamicBoneHelper))

				if var_162_14 then
					var_162_14:EnableDynamicBone(false)
				end

				arg_159_1:ShowWeapon(var_162_13.transform, false)

				arg_159_1.var_[var_162_11 .. "Animator"] = var_162_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_159_1.var_[var_162_11 .. "Animator"].applyRootMotion = true
				arg_159_1.var_[var_162_11 .. "LipSync"] = var_162_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_162_15 = arg_159_1.actors_["6148ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos6148ui_story = var_162_15.localPosition

				local var_162_16 = GameObjectTools.GetOrAddComponent(var_162_15.gameObject, typeof(DynamicBoneHelper))

				if var_162_16 then
					var_162_16:EnableDynamicBone(false)
				end
			end

			local var_162_17 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_17 then
				var_162_15.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_159_1.time_ - 0) / var_162_17)
				var_162_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_15.position).x, (manager.ui.mainCamera.transform.position - var_162_15.position).y, (manager.ui.mainCamera.transform.position - var_162_15.position).z)
				var_162_15.localEulerAngles.z = 0
				var_162_15.localEulerAngles.x = 0
				var_162_15.localEulerAngles = var_162_15.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_17 and arg_159_1.time_ < 0 + var_162_17 + arg_162_0 then
				var_162_15.localPosition = Vector3.New(0.7, -0.985, -6)
				var_162_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_15.position).x, (manager.ui.mainCamera.transform.position - var_162_15.position).y, (manager.ui.mainCamera.transform.position - var_162_15.position).z)
				var_162_15.localEulerAngles.z = 0
				var_162_15.localEulerAngles.x = 0
				var_162_15.localEulerAngles = var_162_15.localEulerAngles

				local var_162_18 = GameObjectTools.GetOrAddComponent(var_162_15.gameObject, typeof(DynamicBoneHelper))

				if var_162_18 then
					var_162_18:EnableDynamicBone(true)
				end
			end

			local var_162_19 = arg_159_1.actors_["10175ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_19) and arg_159_1.var_.characterEffect10175ui_story == nil then
				arg_159_1.var_.characterEffect10175ui_story = var_162_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_20 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_20 and not isNil(var_162_19) then
				if arg_159_1.var_.characterEffect10175ui_story and not isNil(var_162_19) then
					arg_159_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_20)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_20 and arg_159_1.time_ < 0 + var_162_20 + arg_162_0 and not isNil(var_162_19) and arg_159_1.var_.characterEffect10175ui_story then
				arg_159_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_162_21 = arg_159_1.actors_["1054ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_21) and arg_159_1.var_.characterEffect1054ui_story == nil then
				arg_159_1.var_.characterEffect1054ui_story = var_162_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_22 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_22 and not isNil(var_162_21) then
				if arg_159_1.var_.characterEffect1054ui_story and not isNil(var_162_21) then
					arg_159_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_22 and arg_159_1.time_ < 0 + var_162_22 + arg_162_0 and not isNil(var_162_21) and arg_159_1.var_.characterEffect1054ui_story then
				arg_159_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_162_24 = arg_159_1.actors_["6148ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_24) and arg_159_1.var_.characterEffect6148ui_story == nil then
				arg_159_1.var_.characterEffect6148ui_story = var_162_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_25 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_25 and not isNil(var_162_24) then
				if arg_159_1.var_.characterEffect6148ui_story and not isNil(var_162_24) then
					arg_159_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_25 and arg_159_1.time_ < 0 + var_162_25 + arg_162_0 and not isNil(var_162_24) and arg_159_1.var_.characterEffect6148ui_story then
				arg_159_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_162_28 = 0
			local var_162_29 = 0.55

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_28 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1489].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_30 = arg_159_1:GetWordFromCfg(325582038)
				local var_162_31 = arg_159_1:FormatText(var_162_30.content)

				arg_159_1.text_.text = var_162_31

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_33 = 22 <= 0 and var_162_29 or var_162_29 * (utf8.len(var_162_31) / 22)

				if (22 <= 0 and var_162_29 or var_162_29 * (utf8.len(var_162_31) / 22)) > 0 and var_162_29 < var_162_33 then
					arg_159_1.talkMaxDuration = var_162_33

					if var_162_33 + var_162_28 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_33 + var_162_28
					end
				end

				arg_159_1.text_.text = var_162_31
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325582", "325582038", "story_v_out_325582.awb") ~= 0 then
					local var_162_34 = manager.audio:GetVoiceLength("story_v_out_325582", "325582038", "story_v_out_325582.awb") / 1000

					if var_162_34 + var_162_28 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_34 + var_162_28
					end

					if var_162_30.prefab_name ~= "" and arg_159_1.actors_[var_162_30.prefab_name] ~= nil then
						local var_162_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_30.prefab_name].transform, "story_v_out_325582", "325582038", "story_v_out_325582.awb")

						arg_159_1:RecordAudio("325582038", var_162_35)
						arg_159_1:RecordAudio("325582038", var_162_35)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_325582", "325582038", "story_v_out_325582.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_325582", "325582038", "story_v_out_325582.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_36 = math.max(var_162_29, arg_159_1.talkMaxDuration)

			if var_162_28 <= arg_159_1.time_ and arg_159_1.time_ < var_162_28 + var_162_36 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_28) / var_162_36

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_28 + var_162_36 and arg_159_1.time_ < var_162_28 + var_162_36 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J26h"
	},
	voices = {
		"story_v_out_325582.awb"
	}
}
