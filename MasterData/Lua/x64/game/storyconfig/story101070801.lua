return {
	Play107081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 107081001
		arg_1_1.duration_ = 7.13

		local var_1_0 = {
			ja = 5.733,
			ko = 7.133,
			zh = 6.233,
			en = 6.433
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
				arg_1_0:Play107081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.C06b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C06b")
				var_4_0.name = "C06b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.C06b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.C06b

				arg_1_1.bgs_.C06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C06b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.C06b:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueC06b = var_4_4.color.a
					arg_1_1.var_.alphaMatValueC06b = var_4_4
				end

				arg_1_1.var_.alphaOldValueC06b = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueC06b then
					arg_1_1.var_.alphaMatValueC06b.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueC06b, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueC06b.color = arg_1_1.var_.alphaMatValueC06b.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueC06b then
				arg_1_1.var_.alphaMatValueC06b.color.a = 1
				arg_1_1.var_.alphaMatValueC06b.color = arg_1_1.var_.alphaMatValueC06b.color
			end

			local var_4_6 = "1058ui_story"

			if arg_1_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_4_7 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_1_1.stage_.transform)

				var_4_7.name = var_4_6
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_6] = var_4_7

				local var_4_8 = var_4_7:GetComponentInChildren(typeof(CharacterEffect))

				var_4_8.enabled = true

				local var_4_9 = GameObjectTools.GetOrAddComponent(var_4_7, typeof(DynamicBoneHelper))

				if var_4_9 then
					var_4_9:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_8.transform, false)

				arg_1_1.var_[var_4_6 .. "Animator"] = var_4_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_6 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_6 .. "LipSync"] = var_4_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_10 = arg_1_1.actors_["1058ui_story"]

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 and not isNil(var_4_10) and arg_1_1.var_.characterEffect1058ui_story == nil then
				arg_1_1.var_.characterEffect1058ui_story = var_4_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_11 = 0.1

			if 1 <= arg_1_1.time_ and arg_1_1.time_ < 1 + var_4_11 and not isNil(var_4_10) then
				if arg_1_1.var_.characterEffect1058ui_story and not isNil(var_4_10) then
					arg_1_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1 + var_4_11 and arg_1_1.time_ < 1 + var_4_11 + arg_4_0 and not isNil(var_4_10) and arg_1_1.var_.characterEffect1058ui_story then
				arg_1_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_4_13 = arg_1_1.actors_["1058ui_story"].transform

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1.var_.moveOldPos1058ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1 <= arg_1_1.time_ and arg_1_1.time_ < 1 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_1_1.time_ - 1) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1 + var_4_14 and arg_1_1.time_ < 1 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.95, -5.88)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_1")
			end

			local var_4_15 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_15 + 1 and arg_1_1.time_ < var_4_15 + 1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_18 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 1
			local var_4_20 = 0.65

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_22 = arg_1_1:GetWordFromCfg(107081001)
				local var_4_23 = arg_1_1:FormatText(var_4_22.content)

				arg_1_1.text_.text = var_4_23

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_25 = 28 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_23) / 28)

				if (28 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_23) / 28)) > 0 and var_4_20 < var_4_25 then
					arg_1_1.talkMaxDuration = var_4_25
					var_4_19 = var_4_19 + 0.3

					if var_4_25 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_23
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081001", "story_v_out_107081.awb") ~= 0 then
					local var_4_26 = manager.audio:GetVoiceLength("story_v_out_107081", "107081001", "story_v_out_107081.awb") / 1000

					if var_4_26 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_19
					end

					if var_4_22.prefab_name ~= "" and arg_1_1.actors_[var_4_22.prefab_name] ~= nil then
						local var_4_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_22.prefab_name].transform, "story_v_out_107081", "107081001", "story_v_out_107081.awb")

						arg_1_1:RecordAudio("107081001", var_4_27)
						arg_1_1:RecordAudio("107081001", var_4_27)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_107081", "107081001", "story_v_out_107081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_107081", "107081001", "story_v_out_107081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_28 = var_4_19 + 0.3
			local var_4_29 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_28) / var_4_29

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play107081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 107081002
		arg_8_1.duration_ = 2.7

		local var_8_0 = {
			ja = 2.7,
			ko = 1.633,
			zh = 2.266,
			en = 1.433
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play107081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1058ui_story"]) and arg_8_1.var_.characterEffect1058ui_story == nil then
				arg_8_1.var_.characterEffect1058ui_story = arg_8_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1058ui_story"]) then
				if arg_8_1.var_.characterEffect1058ui_story and not isNil(arg_8_1.actors_["1058ui_story"]) then
					arg_8_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1058ui_story"]) and arg_8_1.var_.characterEffect1058ui_story then
				arg_8_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 0.175

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(107081002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_6 = 7 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 7)

				if (7 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 7)) > 0 and var_11_2 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081002", "story_v_out_107081.awb") ~= 0 then
					local var_11_7 = manager.audio:GetVoiceLength("story_v_out_107081", "107081002", "story_v_out_107081.awb") / 1000

					if var_11_7 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_1
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_107081", "107081002", "story_v_out_107081.awb")

						arg_8_1:RecordAudio("107081002", var_11_8)
						arg_8_1:RecordAudio("107081002", var_11_8)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_107081", "107081002", "story_v_out_107081.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_107081", "107081002", "story_v_out_107081.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_9 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_9 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_9

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_9 and arg_8_1.time_ < var_11_1 + var_11_9 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play107081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 107081003
		arg_12_1.duration_ = 8.33

		local var_12_0 = {
			ja = 6.133,
			ko = 5.966,
			zh = 8.333,
			en = 6.333
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play107081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.325

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[91].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10012")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:GetWordFromCfg(107081003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 13 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 13)

				if (13 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 13)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081003", "story_v_out_107081.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_107081", "107081003", "story_v_out_107081.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_107081", "107081003", "story_v_out_107081.awb")

						arg_12_1:RecordAudio("107081003", var_15_6)
						arg_12_1:RecordAudio("107081003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_107081", "107081003", "story_v_out_107081.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_107081", "107081003", "story_v_out_107081.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play107081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 107081004
		arg_16_1.duration_ = 6.93

		local var_16_0 = {
			ja = 6.933,
			ko = 4.466,
			zh = 4.133,
			en = 6.5
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
				arg_16_0:Play107081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1058ui_story"]) and arg_16_1.var_.characterEffect1058ui_story == nil then
				arg_16_1.var_.characterEffect1058ui_story = arg_16_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1058ui_story"]) then
				if arg_16_1.var_.characterEffect1058ui_story and not isNil(arg_16_1.actors_["1058ui_story"]) then
					arg_16_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1058ui_story"]) and arg_16_1.var_.characterEffect1058ui_story then
				arg_16_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058actionlink/1058action443")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_19_2 = 0
			local var_19_3 = 0.55

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_4 = arg_16_1:GetWordFromCfg(107081004)
				local var_19_5 = arg_16_1:FormatText(var_19_4.content)

				arg_16_1.text_.text = var_19_5

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_7 = 22 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_5) / 22)

				if (22 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_5) / 22)) > 0 and var_19_3 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_5
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081004", "story_v_out_107081.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_107081", "107081004", "story_v_out_107081.awb") / 1000

					if var_19_8 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_2
					end

					if var_19_4.prefab_name ~= "" and arg_16_1.actors_[var_19_4.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_4.prefab_name].transform, "story_v_out_107081", "107081004", "story_v_out_107081.awb")

						arg_16_1:RecordAudio("107081004", var_19_9)
						arg_16_1:RecordAudio("107081004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_107081", "107081004", "story_v_out_107081.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_107081", "107081004", "story_v_out_107081.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_3, arg_16_1.talkMaxDuration)

			if var_19_2 <= arg_16_1.time_ and arg_16_1.time_ < var_19_2 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_2) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_2 + var_19_10 and arg_16_1.time_ < var_19_2 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play107081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 107081005
		arg_20_1.duration_ = 6.13

		local var_20_0 = {
			ja = 6.133,
			ko = 4.8,
			zh = 3.366,
			en = 4.7
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play107081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058actionlink/1058action436")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_23_0 = 0
			local var_23_1 = 0.425

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(107081005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 18 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 18)

				if (18 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 18)) > 0 and var_23_1 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081005", "story_v_out_107081.awb") ~= 0 then
					local var_23_6 = manager.audio:GetVoiceLength("story_v_out_107081", "107081005", "story_v_out_107081.awb") / 1000

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end

					if var_23_2.prefab_name ~= "" and arg_20_1.actors_[var_23_2.prefab_name] ~= nil then
						local var_23_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_2.prefab_name].transform, "story_v_out_107081", "107081005", "story_v_out_107081.awb")

						arg_20_1:RecordAudio("107081005", var_23_7)
						arg_20_1:RecordAudio("107081005", var_23_7)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_107081", "107081005", "story_v_out_107081.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_107081", "107081005", "story_v_out_107081.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play107081006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 107081006
		arg_24_1.duration_ = 1.2

		local var_24_0 = {
			ja = 1.066,
			ko = 0.966,
			zh = 1.2,
			en = 0.933
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play107081007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1058ui_story"]) and arg_24_1.var_.characterEffect1058ui_story == nil then
				arg_24_1.var_.characterEffect1058ui_story = arg_24_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1058ui_story"]) then
				if arg_24_1.var_.characterEffect1058ui_story and not isNil(arg_24_1.actors_["1058ui_story"]) then
					arg_24_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1058ui_story"]) and arg_24_1.var_.characterEffect1058ui_story then
				arg_24_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.05

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(107081006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 2 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_4) / 2)

				if (2 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_4) / 2)) > 0 and var_27_2 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081006", "story_v_out_107081.awb") ~= 0 then
					local var_27_7 = manager.audio:GetVoiceLength("story_v_out_107081", "107081006", "story_v_out_107081.awb") / 1000

					if var_27_7 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_1
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_107081", "107081006", "story_v_out_107081.awb")

						arg_24_1:RecordAudio("107081006", var_27_8)
						arg_24_1:RecordAudio("107081006", var_27_8)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_107081", "107081006", "story_v_out_107081.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_107081", "107081006", "story_v_out_107081.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_9 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_9 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_9

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_9 and arg_24_1.time_ < var_27_1 + var_27_9 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play107081007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 107081007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play107081008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 1.375

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(107081007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 55 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 55)

				if (55 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 55)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play107081008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 107081008
		arg_32_1.duration_ = 3.47

		local var_32_0 = {
			ja = 3.466,
			ko = 1.133,
			zh = 2.166,
			en = 2.533
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
				arg_32_0:Play107081009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:AudioAction("play", "effect", "se_story_7", "se_story_7_shock", "")
			end

			local var_35_1 = 0
			local var_35_2 = 0.125

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(107081008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_6 = 5 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_4) / 5)

				if (5 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_4) / 5)) > 0 and var_35_2 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6

					if var_35_6 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081008", "story_v_out_107081.awb") ~= 0 then
					local var_35_7 = manager.audio:GetVoiceLength("story_v_out_107081", "107081008", "story_v_out_107081.awb") / 1000

					if var_35_7 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_1
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_107081", "107081008", "story_v_out_107081.awb")

						arg_32_1:RecordAudio("107081008", var_35_8)
						arg_32_1:RecordAudio("107081008", var_35_8)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_107081", "107081008", "story_v_out_107081.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_107081", "107081008", "story_v_out_107081.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_9 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_9 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_9

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_9 and arg_32_1.time_ < var_35_1 + var_35_9 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play107081009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 107081009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play107081010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_39_0 = 0.6

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				local var_39_1, var_39_2 = math.modf((arg_36_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_39_2 * 0.13, var_39_2 * 0.13, var_39_2 * 0.13) + arg_36_1.var_.shakeOldPos
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				manager.ui.mainCamera.transform.localPosition = arg_36_1.var_.shakeOldPos
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:AudioAction("play", "effect", "se_story_7", "se_story_7_shock02", "")
			end

			local var_39_4 = 0
			local var_39_5 = 0.225

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(107081009).content)

				arg_36_1.text_.text = var_39_6

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_8 = 9 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_6) / 9)

				if (9 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_6) / 9)) > 0 and var_39_5 < var_39_8 then
					arg_36_1.talkMaxDuration = var_39_8

					if var_39_8 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_6
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_9 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_9 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_9

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_9 and arg_36_1.time_ < var_39_4 + var_39_9 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play107081010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 107081010
		arg_40_1.duration_ = 2.9

		local var_40_0 = {
			ja = 2.566,
			ko = 2.666,
			zh = 2.2,
			en = 2.9
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
				arg_40_0:Play107081011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1058ui_story"]) and arg_40_1.var_.characterEffect1058ui_story == nil then
				arg_40_1.var_.characterEffect1058ui_story = arg_40_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1058ui_story"]) then
				if arg_40_1.var_.characterEffect1058ui_story and not isNil(arg_40_1.actors_["1058ui_story"]) then
					arg_40_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1058ui_story"]) and arg_40_1.var_.characterEffect1058ui_story then
				arg_40_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058actionlink/1058action464")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_43_2 = 0
			local var_43_3 = 0.2

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_4 = arg_40_1:GetWordFromCfg(107081010)
				local var_43_5 = arg_40_1:FormatText(var_43_4.content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 8 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 8)

				if (8 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 8)) > 0 and var_43_3 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_2
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081010", "story_v_out_107081.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_107081", "107081010", "story_v_out_107081.awb") / 1000

					if var_43_8 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_2
					end

					if var_43_4.prefab_name ~= "" and arg_40_1.actors_[var_43_4.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_4.prefab_name].transform, "story_v_out_107081", "107081010", "story_v_out_107081.awb")

						arg_40_1:RecordAudio("107081010", var_43_9)
						arg_40_1:RecordAudio("107081010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_107081", "107081010", "story_v_out_107081.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_107081", "107081010", "story_v_out_107081.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_3, arg_40_1.talkMaxDuration)

			if var_43_2 <= arg_40_1.time_ and arg_40_1.time_ < var_43_2 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_2) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_2 + var_43_10 and arg_40_1.time_ < var_43_2 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play107081011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 107081011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play107081012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1058ui_story"]) and arg_44_1.var_.characterEffect1058ui_story == nil then
				arg_44_1.var_.characterEffect1058ui_story = arg_44_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1058ui_story"]) then
				if arg_44_1.var_.characterEffect1058ui_story and not isNil(arg_44_1.actors_["1058ui_story"]) then
					arg_44_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1058ui_story"]) and arg_44_1.var_.characterEffect1058ui_story then
				arg_44_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_47_1 = arg_44_1.actors_["1058ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1058ui_story = var_47_1.localPosition
			end

			local var_47_2 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 then
				var_47_1.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_2)
				var_47_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_1.position).x, (manager.ui.mainCamera.transform.position - var_47_1.position).y, (manager.ui.mainCamera.transform.position - var_47_1.position).z)
				var_47_1.localEulerAngles.z = 0
				var_47_1.localEulerAngles.x = 0
				var_47_1.localEulerAngles = var_47_1.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 then
				var_47_1.localPosition = Vector3.New(0, 100, 0)
				var_47_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_1.position).x, (manager.ui.mainCamera.transform.position - var_47_1.position).y, (manager.ui.mainCamera.transform.position - var_47_1.position).z)
				var_47_1.localEulerAngles.z = 0
				var_47_1.localEulerAngles.x = 0
				var_47_1.localEulerAngles = var_47_1.localEulerAngles
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:AudioAction("play", "effect", "se_story_7", "se_story_7_shock03", "")
			end

			local var_47_4 = 0
			local var_47_5 = 1.05

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(107081011).content)

				arg_44_1.text_.text = var_47_6

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_8 = 42 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_6) / 42)

				if (42 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_6) / 42)) > 0 and var_47_5 < var_47_8 then
					arg_44_1.talkMaxDuration = var_47_8

					if var_47_8 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_6
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_9 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_9 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_9

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_9 and arg_44_1.time_ < var_47_4 + var_47_9 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play107081012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 107081012
		arg_48_1.duration_ = 3

		local var_48_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 3
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
				arg_48_0:Play107081013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058actionlink/1058action446")
			end

			local var_51_0 = 0
			local var_51_1 = 0.175

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(107081012)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 7 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 7)

				if (7 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 7)) > 0 and var_51_1 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081012", "story_v_out_107081.awb") ~= 0 then
					local var_51_6 = manager.audio:GetVoiceLength("story_v_out_107081", "107081012", "story_v_out_107081.awb") / 1000

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end

					if var_51_2.prefab_name ~= "" and arg_48_1.actors_[var_51_2.prefab_name] ~= nil then
						local var_51_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_2.prefab_name].transform, "story_v_out_107081", "107081012", "story_v_out_107081.awb")

						arg_48_1:RecordAudio("107081012", var_51_7)
						arg_48_1:RecordAudio("107081012", var_51_7)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_107081", "107081012", "story_v_out_107081.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_107081", "107081012", "story_v_out_107081.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play107081013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 107081013
		arg_52_1.duration_ = 3.67

		local var_52_0 = {
			ja = 3.666,
			ko = 3.3,
			zh = 2.333,
			en = 2.633
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play107081014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1058ui_story"]) and arg_52_1.var_.characterEffect1058ui_story == nil then
				arg_52_1.var_.characterEffect1058ui_story = arg_52_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1058ui_story"]) then
				if arg_52_1.var_.characterEffect1058ui_story and not isNil(arg_52_1.actors_["1058ui_story"]) then
					arg_52_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1058ui_story"]) and arg_52_1.var_.characterEffect1058ui_story then
				arg_52_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_55_2 = 0
			local var_55_3 = 0.3

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1058")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_4 = arg_52_1:GetWordFromCfg(107081013)
				local var_55_5 = arg_52_1:FormatText(var_55_4.content)

				arg_52_1.text_.text = var_55_5

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_7 = 12 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 12)

				if (12 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 12)) > 0 and var_55_3 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_2
					end
				end

				arg_52_1.text_.text = var_55_5
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081013", "story_v_out_107081.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_107081", "107081013", "story_v_out_107081.awb") / 1000

					if var_55_8 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_2
					end

					if var_55_4.prefab_name ~= "" and arg_52_1.actors_[var_55_4.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_4.prefab_name].transform, "story_v_out_107081", "107081013", "story_v_out_107081.awb")

						arg_52_1:RecordAudio("107081013", var_55_9)
						arg_52_1:RecordAudio("107081013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_107081", "107081013", "story_v_out_107081.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_107081", "107081013", "story_v_out_107081.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_3, arg_52_1.talkMaxDuration)

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_2) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_2 + var_55_10 and arg_52_1.time_ < var_55_2 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play107081014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 107081014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play107081015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1058ui_story"]) and arg_56_1.var_.characterEffect1058ui_story == nil then
				arg_56_1.var_.characterEffect1058ui_story = arg_56_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1058ui_story"]) then
				if arg_56_1.var_.characterEffect1058ui_story and not isNil(arg_56_1.actors_["1058ui_story"]) then
					arg_56_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1058ui_story"]) and arg_56_1.var_.characterEffect1058ui_story then
				arg_56_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_59_1 = arg_56_1.actors_["1058ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1058ui_story = var_59_1.localPosition
			end

			local var_59_2 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 then
				var_59_1.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_2)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 then
				var_59_1.localPosition = Vector3.New(0, 100, 0)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			local var_59_3 = "3007_tpose"

			if arg_56_1.actors_["3007_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3007_tpose"))) then
				local var_59_4 = Object.Instantiate(Asset.Load("Char/" .. "3007_tpose"), arg_56_1.stage_.transform)

				var_59_4.name = var_59_3
				var_59_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_[var_59_3] = var_59_4

				local var_59_5 = var_59_4:GetComponentInChildren(typeof(CharacterEffect))

				var_59_5.enabled = true

				local var_59_6 = GameObjectTools.GetOrAddComponent(var_59_4, typeof(DynamicBoneHelper))

				if var_59_6 then
					var_59_6:EnableDynamicBone(false)
				end

				arg_56_1:ShowWeapon(var_59_5.transform, false)

				arg_56_1.var_[var_59_3 .. "Animator"] = var_59_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_56_1.var_[var_59_3 .. "Animator"].applyRootMotion = true
				arg_56_1.var_[var_59_3 .. "LipSync"] = var_59_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_59_7 = arg_56_1.actors_["3007_tpose"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos3007_tpose = var_59_7.localPosition

				local var_59_8 = GameObjectTools.GetOrAddComponent(var_59_7.gameObject, typeof(DynamicBoneHelper))

				if var_59_8 then
					var_59_8:EnableDynamicBone(false)
				end
			end

			local var_59_9 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_9 then
				var_59_7.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos3007_tpose, Vector3.New(0, -2.25, -1.9), (arg_56_1.time_ - 0) / var_59_9)
				var_59_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_7.position).x, (manager.ui.mainCamera.transform.position - var_59_7.position).y, (manager.ui.mainCamera.transform.position - var_59_7.position).z)
				var_59_7.localEulerAngles.z = 0
				var_59_7.localEulerAngles.x = 0
				var_59_7.localEulerAngles = var_59_7.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_9 and arg_56_1.time_ < 0 + var_59_9 + arg_59_0 then
				var_59_7.localPosition = Vector3.New(0, -2.25, -1.9)
				var_59_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_7.position).x, (manager.ui.mainCamera.transform.position - var_59_7.position).y, (manager.ui.mainCamera.transform.position - var_59_7.position).z)
				var_59_7.localEulerAngles.z = 0
				var_59_7.localEulerAngles.x = 0
				var_59_7.localEulerAngles = var_59_7.localEulerAngles

				local var_59_10 = GameObjectTools.GetOrAddComponent(var_59_7.gameObject, typeof(DynamicBoneHelper))

				if var_59_10 then
					var_59_10:EnableDynamicBone(true)
				end
			end

			local var_59_11 = 0
			local var_59_12 = 0.625

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_13 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(107081014).content)

				arg_56_1.text_.text = var_59_13

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 25 <= 0 and var_59_12 or var_59_12 * (utf8.len(var_59_13) / 25)

				if (25 <= 0 and var_59_12 or var_59_12 * (utf8.len(var_59_13) / 25)) > 0 and var_59_12 < var_59_15 then
					arg_56_1.talkMaxDuration = var_59_15

					if var_59_15 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_11
					end
				end

				arg_56_1.text_.text = var_59_13
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_12, arg_56_1.talkMaxDuration)

			if var_59_11 <= arg_56_1.time_ and arg_56_1.time_ < var_59_11 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_11) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_11 + var_59_16 and arg_56_1.time_ < var_59_11 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play107081015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 107081015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play107081016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 1.025

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(107081015).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 41 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 41)

				if (41 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 41)) > 0 and var_63_0 < var_63_3 then
					arg_60_1.talkMaxDuration = var_63_3

					if var_63_3 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_3 + 0
					end
				end

				arg_60_1.text_.text = var_63_1
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_4 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_4

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play107081016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 107081016
		arg_64_1.duration_ = 9.23

		local var_64_0 = {
			ja = 8.366,
			ko = 6,
			zh = 7.8,
			en = 9.233
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play107081017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos3007_tpose = arg_64_1.actors_["3007_tpose"].transform.localPosition

				local var_67_0 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_0 then
					var_67_0:EnableDynamicBone(false)
				end
			end

			local var_67_1 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_1 then
				arg_64_1.actors_["3007_tpose"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos3007_tpose, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_1)
				arg_64_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["3007_tpose"].transform.position).z)
				arg_64_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["3007_tpose"].transform.localEulerAngles = arg_64_1.actors_["3007_tpose"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_1 and arg_64_1.time_ < 0 + var_67_1 + arg_67_0 then
				arg_64_1.actors_["3007_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["3007_tpose"].transform.position).z)
				arg_64_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["3007_tpose"].transform.localEulerAngles = arg_64_1.actors_["3007_tpose"].transform.localEulerAngles

				local var_67_2 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(true)
				end
			end

			local var_67_3 = 0
			local var_67_4 = 0.9

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_3 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_5 = arg_64_1:GetWordFromCfg(107081016)
				local var_67_6 = arg_64_1:FormatText(var_67_5.content)

				arg_64_1.text_.text = var_67_6

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_8 = 36 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_6) / 36)

				if (36 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_6) / 36)) > 0 and var_67_4 < var_67_8 then
					arg_64_1.talkMaxDuration = var_67_8

					if var_67_8 + var_67_3 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_3
					end
				end

				arg_64_1.text_.text = var_67_6
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081016", "story_v_out_107081.awb") ~= 0 then
					local var_67_9 = manager.audio:GetVoiceLength("story_v_out_107081", "107081016", "story_v_out_107081.awb") / 1000

					if var_67_9 + var_67_3 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_3
					end

					if var_67_5.prefab_name ~= "" and arg_64_1.actors_[var_67_5.prefab_name] ~= nil then
						local var_67_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_5.prefab_name].transform, "story_v_out_107081", "107081016", "story_v_out_107081.awb")

						arg_64_1:RecordAudio("107081016", var_67_10)
						arg_64_1:RecordAudio("107081016", var_67_10)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_107081", "107081016", "story_v_out_107081.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_107081", "107081016", "story_v_out_107081.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_11 = math.max(var_67_4, arg_64_1.talkMaxDuration)

			if var_67_3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_3 + var_67_11 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_3) / var_67_11

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_3 + var_67_11 and arg_64_1.time_ < var_67_3 + var_67_11 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play107081017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 107081017
		arg_68_1.duration_ = 5.5

		local var_68_0 = {
			ja = 5.5,
			ko = 3.666,
			zh = 2.8,
			en = 2.066
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
				arg_68_0:Play107081018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1058ui_story"]) and arg_68_1.var_.characterEffect1058ui_story == nil then
				arg_68_1.var_.characterEffect1058ui_story = arg_68_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.1

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1058ui_story"]) then
				if arg_68_1.var_.characterEffect1058ui_story and not isNil(arg_68_1.actors_["1058ui_story"]) then
					arg_68_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1058ui_story"]) and arg_68_1.var_.characterEffect1058ui_story then
				arg_68_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_71_2 = arg_68_1.actors_["1058ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1058ui_story = var_71_2.localPosition
			end

			local var_71_3 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 then
				var_71_2.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_68_1.time_ - 0) / var_71_3)
				var_71_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_2.position).x, (manager.ui.mainCamera.transform.position - var_71_2.position).y, (manager.ui.mainCamera.transform.position - var_71_2.position).z)
				var_71_2.localEulerAngles.z = 0
				var_71_2.localEulerAngles.x = 0
				var_71_2.localEulerAngles = var_71_2.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 then
				var_71_2.localPosition = Vector3.New(0, -0.95, -5.88)
				var_71_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_2.position).x, (manager.ui.mainCamera.transform.position - var_71_2.position).y, (manager.ui.mainCamera.transform.position - var_71_2.position).z)
				var_71_2.localEulerAngles.z = 0
				var_71_2.localEulerAngles.x = 0
				var_71_2.localEulerAngles = var_71_2.localEulerAngles
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action6_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_71_4 = 0
			local var_71_5 = 0.375

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(107081017)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 15 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 15)

				if (15 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 15)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081017", "story_v_out_107081.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_107081", "107081017", "story_v_out_107081.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_107081", "107081017", "story_v_out_107081.awb")

						arg_68_1:RecordAudio("107081017", var_71_11)
						arg_68_1:RecordAudio("107081017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_107081", "107081017", "story_v_out_107081.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_107081", "107081017", "story_v_out_107081.awb")
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

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play107081018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 107081018
		arg_72_1.duration_ = 6.93

		local var_72_0 = {
			ja = 4.2,
			ko = 4.066,
			zh = 4.833,
			en = 6.933
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
				arg_72_0:Play107081019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058actionlink/1058action467")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_75_0 = 0
			local var_75_1 = 0.55

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(107081018)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 22 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 22)

				if (22 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 22)) > 0 and var_75_1 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081018", "story_v_out_107081.awb") ~= 0 then
					local var_75_6 = manager.audio:GetVoiceLength("story_v_out_107081", "107081018", "story_v_out_107081.awb") / 1000

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end

					if var_75_2.prefab_name ~= "" and arg_72_1.actors_[var_75_2.prefab_name] ~= nil then
						local var_75_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_2.prefab_name].transform, "story_v_out_107081", "107081018", "story_v_out_107081.awb")

						arg_72_1:RecordAudio("107081018", var_75_7)
						arg_72_1:RecordAudio("107081018", var_75_7)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_107081", "107081018", "story_v_out_107081.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_107081", "107081018", "story_v_out_107081.awb")
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
	Play107081019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 107081019
		arg_76_1.duration_ = 7.6

		local var_76_0 = {
			ja = 3.2,
			ko = 2.9,
			zh = 4.633,
			en = 7.6
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
				arg_76_0:Play107081020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["3007_tpose"]) and arg_76_1.var_.characterEffect3007_tpose == nil then
				arg_76_1.var_.characterEffect3007_tpose = arg_76_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["3007_tpose"]) then
				if arg_76_1.var_.characterEffect3007_tpose and not isNil(arg_76_1.actors_["3007_tpose"]) then
					arg_76_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["3007_tpose"]) and arg_76_1.var_.characterEffect3007_tpose then
				arg_76_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_79_2 = arg_76_1.actors_["1058ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1058ui_story == nil then
				arg_76_1.var_.characterEffect1058ui_story = var_79_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_3 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.characterEffect1058ui_story and not isNil(var_79_2) then
					arg_76_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_3)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1058ui_story then
				arg_76_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_79_4 = arg_76_1.actors_["1058ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1058ui_story = var_79_4.localPosition
			end

			local var_79_5 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_5 then
				var_79_4.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 0) / var_79_5)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_5 and arg_76_1.time_ < 0 + var_79_5 + arg_79_0 then
				var_79_4.localPosition = Vector3.New(0, 100, 0)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_79_6 = arg_76_1.actors_["3007_tpose"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos3007_tpose = var_79_6.localPosition

				local var_79_7 = GameObjectTools.GetOrAddComponent(var_79_6.gameObject, typeof(DynamicBoneHelper))

				if var_79_7 then
					var_79_7:EnableDynamicBone(false)
				end
			end

			local var_79_8 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_8 then
				var_79_6.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos3007_tpose, Vector3.New(0, -2.25, -1.9), (arg_76_1.time_ - 0) / var_79_8)
				var_79_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_6.position).x, (manager.ui.mainCamera.transform.position - var_79_6.position).y, (manager.ui.mainCamera.transform.position - var_79_6.position).z)
				var_79_6.localEulerAngles.z = 0
				var_79_6.localEulerAngles.x = 0
				var_79_6.localEulerAngles = var_79_6.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_8 and arg_76_1.time_ < 0 + var_79_8 + arg_79_0 then
				var_79_6.localPosition = Vector3.New(0, -2.25, -1.9)
				var_79_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_6.position).x, (manager.ui.mainCamera.transform.position - var_79_6.position).y, (manager.ui.mainCamera.transform.position - var_79_6.position).z)
				var_79_6.localEulerAngles.z = 0
				var_79_6.localEulerAngles.x = 0
				var_79_6.localEulerAngles = var_79_6.localEulerAngles

				local var_79_9 = GameObjectTools.GetOrAddComponent(var_79_6.gameObject, typeof(DynamicBoneHelper))

				if var_79_9 then
					var_79_9:EnableDynamicBone(true)
				end
			end

			local var_79_10 = 0
			local var_79_11 = 0.275

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[98].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_12 = arg_76_1:GetWordFromCfg(107081019)
				local var_79_13 = arg_76_1:FormatText(var_79_12.content)

				arg_76_1.text_.text = var_79_13

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_15 = 11 <= 0 and var_79_11 or var_79_11 * (utf8.len(var_79_13) / 11)

				if (11 <= 0 and var_79_11 or var_79_11 * (utf8.len(var_79_13) / 11)) > 0 and var_79_11 < var_79_15 then
					arg_76_1.talkMaxDuration = var_79_15

					if var_79_15 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_15 + var_79_10
					end
				end

				arg_76_1.text_.text = var_79_13
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081019", "story_v_out_107081.awb") ~= 0 then
					local var_79_16 = manager.audio:GetVoiceLength("story_v_out_107081", "107081019", "story_v_out_107081.awb") / 1000

					if var_79_16 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_16 + var_79_10
					end

					if var_79_12.prefab_name ~= "" and arg_76_1.actors_[var_79_12.prefab_name] ~= nil then
						local var_79_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_12.prefab_name].transform, "story_v_out_107081", "107081019", "story_v_out_107081.awb")

						arg_76_1:RecordAudio("107081019", var_79_17)
						arg_76_1:RecordAudio("107081019", var_79_17)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_107081", "107081019", "story_v_out_107081.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_107081", "107081019", "story_v_out_107081.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_18 = math.max(var_79_11, arg_76_1.talkMaxDuration)

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_18 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_10) / var_79_18

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_10 + var_79_18 and arg_76_1.time_ < var_79_10 + var_79_18 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play107081020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 107081020
		arg_80_1.duration_ = 1.87

		local var_80_0 = {
			ja = 1.866,
			ko = 1.633,
			zh = 1.4,
			en = 1.5
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
				arg_80_0:Play107081021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["3007_tpose"]) and arg_80_1.var_.characterEffect3007_tpose == nil then
				arg_80_1.var_.characterEffect3007_tpose = arg_80_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["3007_tpose"]) then
				if arg_80_1.var_.characterEffect3007_tpose and not isNil(arg_80_1.actors_["3007_tpose"]) then
					arg_80_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_80_1.var_.characterEffect3007_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["3007_tpose"]) and arg_80_1.var_.characterEffect3007_tpose then
				arg_80_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_80_1.var_.characterEffect3007_tpose.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.1

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(107081020)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_6 = 4 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_4) / 4)

				if (4 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_4) / 4)) > 0 and var_83_2 < var_83_6 then
					arg_80_1.talkMaxDuration = var_83_6

					if var_83_6 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081020", "story_v_out_107081.awb") ~= 0 then
					local var_83_7 = manager.audio:GetVoiceLength("story_v_out_107081", "107081020", "story_v_out_107081.awb") / 1000

					if var_83_7 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_1
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_107081", "107081020", "story_v_out_107081.awb")

						arg_80_1:RecordAudio("107081020", var_83_8)
						arg_80_1:RecordAudio("107081020", var_83_8)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_107081", "107081020", "story_v_out_107081.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_107081", "107081020", "story_v_out_107081.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_9 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_9 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_9

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_9 and arg_80_1.time_ < var_83_1 + var_83_9 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play107081021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 107081021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play107081022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 1.375

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(107081021).content)

				arg_84_1.text_.text = var_87_1

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_3 = 55 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 55)

				if (55 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 55)) > 0 and var_87_0 < var_87_3 then
					arg_84_1.talkMaxDuration = var_87_3

					if var_87_3 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_3 + 0
					end
				end

				arg_84_1.text_.text = var_87_1
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_4 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_4

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play107081022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 107081022
		arg_88_1.duration_ = 2.3

		local var_88_0 = {
			ja = 1.366,
			ko = 1.433,
			zh = 1.6,
			en = 2.3
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play107081023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos3007_tpose = arg_88_1.actors_["3007_tpose"].transform.localPosition

				local var_91_0 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_0 then
					var_91_0:EnableDynamicBone(false)
				end
			end

			local var_91_1 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_1 then
				arg_88_1.actors_["3007_tpose"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos3007_tpose, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_1)
				arg_88_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["3007_tpose"].transform.position).z)
				arg_88_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["3007_tpose"].transform.localEulerAngles = arg_88_1.actors_["3007_tpose"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_1 and arg_88_1.time_ < 0 + var_91_1 + arg_91_0 then
				arg_88_1.actors_["3007_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["3007_tpose"].transform.position).z)
				arg_88_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["3007_tpose"].transform.localEulerAngles = arg_88_1.actors_["3007_tpose"].transform.localEulerAngles

				local var_91_2 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(true)
				end
			end

			local var_91_3 = 0
			local var_91_4 = 0.15

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_3 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_5 = arg_88_1:GetWordFromCfg(107081022)
				local var_91_6 = arg_88_1:FormatText(var_91_5.content)

				arg_88_1.text_.text = var_91_6

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_8 = 6 <= 0 and var_91_4 or var_91_4 * (utf8.len(var_91_6) / 6)

				if (6 <= 0 and var_91_4 or var_91_4 * (utf8.len(var_91_6) / 6)) > 0 and var_91_4 < var_91_8 then
					arg_88_1.talkMaxDuration = var_91_8

					if var_91_8 + var_91_3 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_3
					end
				end

				arg_88_1.text_.text = var_91_6
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081022", "story_v_out_107081.awb") ~= 0 then
					local var_91_9 = manager.audio:GetVoiceLength("story_v_out_107081", "107081022", "story_v_out_107081.awb") / 1000

					if var_91_9 + var_91_3 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_3
					end

					if var_91_5.prefab_name ~= "" and arg_88_1.actors_[var_91_5.prefab_name] ~= nil then
						local var_91_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_5.prefab_name].transform, "story_v_out_107081", "107081022", "story_v_out_107081.awb")

						arg_88_1:RecordAudio("107081022", var_91_10)
						arg_88_1:RecordAudio("107081022", var_91_10)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_107081", "107081022", "story_v_out_107081.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_107081", "107081022", "story_v_out_107081.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_11 = math.max(var_91_4, arg_88_1.talkMaxDuration)

			if var_91_3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_3 + var_91_11 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_3) / var_91_11

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_3 + var_91_11 and arg_88_1.time_ < var_91_3 + var_91_11 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play107081023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 107081023
		arg_92_1.duration_ = 11.5

		local var_92_0 = {
			ja = 8.733,
			ko = 10.7,
			zh = 9.2,
			en = 11.5
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play107081024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1058ui_story"]) and arg_92_1.var_.characterEffect1058ui_story == nil then
				arg_92_1.var_.characterEffect1058ui_story = arg_92_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1058ui_story"]) then
				if arg_92_1.var_.characterEffect1058ui_story and not isNil(arg_92_1.actors_["1058ui_story"]) then
					arg_92_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1058ui_story"]) and arg_92_1.var_.characterEffect1058ui_story then
				arg_92_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_95_2 = arg_92_1.actors_["1058ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1058ui_story = var_95_2.localPosition
			end

			local var_95_3 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_3 then
				var_95_2.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_92_1.time_ - 0) / var_95_3)
				var_95_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_2.position).x, (manager.ui.mainCamera.transform.position - var_95_2.position).y, (manager.ui.mainCamera.transform.position - var_95_2.position).z)
				var_95_2.localEulerAngles.z = 0
				var_95_2.localEulerAngles.x = 0
				var_95_2.localEulerAngles = var_95_2.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_3 and arg_92_1.time_ < 0 + var_95_3 + arg_95_0 then
				var_95_2.localPosition = Vector3.New(0, -0.95, -5.88)
				var_95_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_2.position).x, (manager.ui.mainCamera.transform.position - var_95_2.position).y, (manager.ui.mainCamera.transform.position - var_95_2.position).z)
				var_95_2.localEulerAngles.z = 0
				var_95_2.localEulerAngles.x = 0
				var_95_2.localEulerAngles = var_95_2.localEulerAngles
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_95_4 = 0
			local var_95_5 = 1.225

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_6 = arg_92_1:GetWordFromCfg(107081023)
				local var_95_7 = arg_92_1:FormatText(var_95_6.content)

				arg_92_1.text_.text = var_95_7

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 50 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 50)

				if (50 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 50)) > 0 and var_95_5 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9

					if var_95_9 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_7
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081023", "story_v_out_107081.awb") ~= 0 then
					local var_95_10 = manager.audio:GetVoiceLength("story_v_out_107081", "107081023", "story_v_out_107081.awb") / 1000

					if var_95_10 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_4
					end

					if var_95_6.prefab_name ~= "" and arg_92_1.actors_[var_95_6.prefab_name] ~= nil then
						local var_95_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_6.prefab_name].transform, "story_v_out_107081", "107081023", "story_v_out_107081.awb")

						arg_92_1:RecordAudio("107081023", var_95_11)
						arg_92_1:RecordAudio("107081023", var_95_11)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_107081", "107081023", "story_v_out_107081.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_107081", "107081023", "story_v_out_107081.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_12 = math.max(var_95_5, arg_92_1.talkMaxDuration)

			if var_95_4 <= arg_92_1.time_ and arg_92_1.time_ < var_95_4 + var_95_12 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_4) / var_95_12

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_4 + var_95_12 and arg_92_1.time_ < var_95_4 + var_95_12 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play107081024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 107081024
		arg_96_1.duration_ = 9.6

		local var_96_0 = {
			ja = 9.6,
			ko = 4.1,
			zh = 7.9,
			en = 7.7
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play107081025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["3007_tpose"]) and arg_96_1.var_.characterEffect3007_tpose == nil then
				arg_96_1.var_.characterEffect3007_tpose = arg_96_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["3007_tpose"]) then
				if arg_96_1.var_.characterEffect3007_tpose and not isNil(arg_96_1.actors_["3007_tpose"]) then
					arg_96_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["3007_tpose"]) and arg_96_1.var_.characterEffect3007_tpose then
				arg_96_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_99_2 = arg_96_1.actors_["1058ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1058ui_story == nil then
				arg_96_1.var_.characterEffect1058ui_story = var_99_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_3 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 and not isNil(var_99_2) then
				if arg_96_1.var_.characterEffect1058ui_story and not isNil(var_99_2) then
					arg_96_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_3)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1058ui_story then
				arg_96_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_99_4 = arg_96_1.actors_["1058ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1058ui_story = var_99_4.localPosition
			end

			local var_99_5 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_5 then
				var_99_4.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_5)
				var_99_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_4.position).x, (manager.ui.mainCamera.transform.position - var_99_4.position).y, (manager.ui.mainCamera.transform.position - var_99_4.position).z)
				var_99_4.localEulerAngles.z = 0
				var_99_4.localEulerAngles.x = 0
				var_99_4.localEulerAngles = var_99_4.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_5 and arg_96_1.time_ < 0 + var_99_5 + arg_99_0 then
				var_99_4.localPosition = Vector3.New(0, 100, 0)
				var_99_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_4.position).x, (manager.ui.mainCamera.transform.position - var_99_4.position).y, (manager.ui.mainCamera.transform.position - var_99_4.position).z)
				var_99_4.localEulerAngles.z = 0
				var_99_4.localEulerAngles.x = 0
				var_99_4.localEulerAngles = var_99_4.localEulerAngles
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_99_6 = arg_96_1.actors_["3007_tpose"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos3007_tpose = var_99_6.localPosition

				local var_99_7 = GameObjectTools.GetOrAddComponent(var_99_6.gameObject, typeof(DynamicBoneHelper))

				if var_99_7 then
					var_99_7:EnableDynamicBone(false)
				end
			end

			local var_99_8 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_8 then
				var_99_6.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos3007_tpose, Vector3.New(0, -2.25, -1.9), (arg_96_1.time_ - 0) / var_99_8)
				var_99_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_6.position).x, (manager.ui.mainCamera.transform.position - var_99_6.position).y, (manager.ui.mainCamera.transform.position - var_99_6.position).z)
				var_99_6.localEulerAngles.z = 0
				var_99_6.localEulerAngles.x = 0
				var_99_6.localEulerAngles = var_99_6.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_8 and arg_96_1.time_ < 0 + var_99_8 + arg_99_0 then
				var_99_6.localPosition = Vector3.New(0, -2.25, -1.9)
				var_99_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_6.position).x, (manager.ui.mainCamera.transform.position - var_99_6.position).y, (manager.ui.mainCamera.transform.position - var_99_6.position).z)
				var_99_6.localEulerAngles.z = 0
				var_99_6.localEulerAngles.x = 0
				var_99_6.localEulerAngles = var_99_6.localEulerAngles

				local var_99_9 = GameObjectTools.GetOrAddComponent(var_99_6.gameObject, typeof(DynamicBoneHelper))

				if var_99_9 then
					var_99_9:EnableDynamicBone(true)
				end
			end

			local var_99_10 = 0
			local var_99_11 = 0.475

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[98].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_12 = arg_96_1:GetWordFromCfg(107081024)
				local var_99_13 = arg_96_1:FormatText(var_99_12.content)

				arg_96_1.text_.text = var_99_13

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_15 = 19 <= 0 and var_99_11 or var_99_11 * (utf8.len(var_99_13) / 19)

				if (19 <= 0 and var_99_11 or var_99_11 * (utf8.len(var_99_13) / 19)) > 0 and var_99_11 < var_99_15 then
					arg_96_1.talkMaxDuration = var_99_15

					if var_99_15 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_15 + var_99_10
					end
				end

				arg_96_1.text_.text = var_99_13
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081024", "story_v_out_107081.awb") ~= 0 then
					local var_99_16 = manager.audio:GetVoiceLength("story_v_out_107081", "107081024", "story_v_out_107081.awb") / 1000

					if var_99_16 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_16 + var_99_10
					end

					if var_99_12.prefab_name ~= "" and arg_96_1.actors_[var_99_12.prefab_name] ~= nil then
						local var_99_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_12.prefab_name].transform, "story_v_out_107081", "107081024", "story_v_out_107081.awb")

						arg_96_1:RecordAudio("107081024", var_99_17)
						arg_96_1:RecordAudio("107081024", var_99_17)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_107081", "107081024", "story_v_out_107081.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_107081", "107081024", "story_v_out_107081.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_18 = math.max(var_99_11, arg_96_1.talkMaxDuration)

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_18 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_10) / var_99_18

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_10 + var_99_18 and arg_96_1.time_ < var_99_10 + var_99_18 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play107081025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 107081025
		arg_100_1.duration_ = 4.8

		local var_100_0 = {
			ja = 4.8,
			ko = 3.933,
			zh = 2.7,
			en = 3.333
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play107081026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["3007_tpose"]) and arg_100_1.var_.characterEffect3007_tpose == nil then
				arg_100_1.var_.characterEffect3007_tpose = arg_100_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["3007_tpose"]) then
				if arg_100_1.var_.characterEffect3007_tpose and not isNil(arg_100_1.actors_["3007_tpose"]) then
					arg_100_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_100_1.var_.characterEffect3007_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["3007_tpose"]) and arg_100_1.var_.characterEffect3007_tpose then
				arg_100_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_100_1.var_.characterEffect3007_tpose.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 0.3

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(107081025)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_6 = 12 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_4) / 12)

				if (12 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_4) / 12)) > 0 and var_103_2 < var_103_6 then
					arg_100_1.talkMaxDuration = var_103_6

					if var_103_6 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081025", "story_v_out_107081.awb") ~= 0 then
					local var_103_7 = manager.audio:GetVoiceLength("story_v_out_107081", "107081025", "story_v_out_107081.awb") / 1000

					if var_103_7 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_1
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_107081", "107081025", "story_v_out_107081.awb")

						arg_100_1:RecordAudio("107081025", var_103_8)
						arg_100_1:RecordAudio("107081025", var_103_8)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_107081", "107081025", "story_v_out_107081.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_107081", "107081025", "story_v_out_107081.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_9 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_9 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_9

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_9 and arg_100_1.time_ < var_103_1 + var_103_9 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play107081026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 107081026
		arg_104_1.duration_ = 5.43

		local var_104_0 = {
			ja = 5.433,
			ko = 2.8,
			zh = 4.1,
			en = 4.466
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play107081027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["3007_tpose"]) and arg_104_1.var_.characterEffect3007_tpose == nil then
				arg_104_1.var_.characterEffect3007_tpose = arg_104_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["3007_tpose"]) then
				if arg_104_1.var_.characterEffect3007_tpose and not isNil(arg_104_1.actors_["3007_tpose"]) then
					arg_104_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["3007_tpose"]) and arg_104_1.var_.characterEffect3007_tpose then
				arg_104_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_107_2 = 0
			local var_107_3 = 0.225

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[98].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_4 = arg_104_1:GetWordFromCfg(107081026)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 9 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 9)

				if (9 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 9)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081026", "story_v_out_107081.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_107081", "107081026", "story_v_out_107081.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_out_107081", "107081026", "story_v_out_107081.awb")

						arg_104_1:RecordAudio("107081026", var_107_9)
						arg_104_1:RecordAudio("107081026", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_107081", "107081026", "story_v_out_107081.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_107081", "107081026", "story_v_out_107081.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_10 and arg_104_1.time_ < var_107_2 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play107081027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 107081027
		arg_108_1.duration_ = 3.07

		local var_108_0 = {
			ja = 3.066,
			ko = 2.166,
			zh = 2.766,
			en = 3.033
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play107081028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["3007_tpose"]) and arg_108_1.var_.characterEffect3007_tpose == nil then
				arg_108_1.var_.characterEffect3007_tpose = arg_108_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["3007_tpose"]) then
				if arg_108_1.var_.characterEffect3007_tpose and not isNil(arg_108_1.actors_["3007_tpose"]) then
					arg_108_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_108_1.var_.characterEffect3007_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["3007_tpose"]) and arg_108_1.var_.characterEffect3007_tpose then
				arg_108_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_108_1.var_.characterEffect3007_tpose.fillRatio = 0.5
			end

			local var_111_1 = 0
			local var_111_2 = 0.2

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(107081027)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_6 = 8 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_4) / 8)

				if (8 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_4) / 8)) > 0 and var_111_2 < var_111_6 then
					arg_108_1.talkMaxDuration = var_111_6

					if var_111_6 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081027", "story_v_out_107081.awb") ~= 0 then
					local var_111_7 = manager.audio:GetVoiceLength("story_v_out_107081", "107081027", "story_v_out_107081.awb") / 1000

					if var_111_7 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_1
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_107081", "107081027", "story_v_out_107081.awb")

						arg_108_1:RecordAudio("107081027", var_111_8)
						arg_108_1:RecordAudio("107081027", var_111_8)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_107081", "107081027", "story_v_out_107081.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_107081", "107081027", "story_v_out_107081.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_9 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_9 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_9

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_9 and arg_108_1.time_ < var_111_1 + var_111_9 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play107081028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 107081028
		arg_112_1.duration_ = 5.47

		local var_112_0 = {
			ja = 3.666,
			ko = 2.866,
			zh = 5.033,
			en = 5.466
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play107081029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["3007_tpose"]) and arg_112_1.var_.characterEffect3007_tpose == nil then
				arg_112_1.var_.characterEffect3007_tpose = arg_112_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.1

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["3007_tpose"]) then
				if arg_112_1.var_.characterEffect3007_tpose and not isNil(arg_112_1.actors_["3007_tpose"]) then
					arg_112_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["3007_tpose"]) and arg_112_1.var_.characterEffect3007_tpose then
				arg_112_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_115_2 = 0
			local var_115_3 = 0.275

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[98].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(107081028)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 11 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 11)

				if (11 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 11)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081028", "story_v_out_107081.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_107081", "107081028", "story_v_out_107081.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_107081", "107081028", "story_v_out_107081.awb")

						arg_112_1:RecordAudio("107081028", var_115_9)
						arg_112_1:RecordAudio("107081028", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_107081", "107081028", "story_v_out_107081.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_107081", "107081028", "story_v_out_107081.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play107081029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 107081029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play107081030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["3007_tpose"]) and arg_116_1.var_.characterEffect3007_tpose == nil then
				arg_116_1.var_.characterEffect3007_tpose = arg_116_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.1

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["3007_tpose"]) then
				if arg_116_1.var_.characterEffect3007_tpose and not isNil(arg_116_1.actors_["3007_tpose"]) then
					arg_116_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_116_1.var_.characterEffect3007_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["3007_tpose"]) and arg_116_1.var_.characterEffect3007_tpose then
				arg_116_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_116_1.var_.characterEffect3007_tpose.fillRatio = 0.5
			end

			local var_119_1 = arg_116_1.actors_["3007_tpose"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos3007_tpose = var_119_1.localPosition

				local var_119_2 = GameObjectTools.GetOrAddComponent(var_119_1.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(false)
				end
			end

			local var_119_3 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 then
				var_119_1.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos3007_tpose, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_3)
				var_119_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_1.position).x, (manager.ui.mainCamera.transform.position - var_119_1.position).y, (manager.ui.mainCamera.transform.position - var_119_1.position).z)
				var_119_1.localEulerAngles.z = 0
				var_119_1.localEulerAngles.x = 0
				var_119_1.localEulerAngles = var_119_1.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 then
				var_119_1.localPosition = Vector3.New(0, 100, 0)
				var_119_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_1.position).x, (manager.ui.mainCamera.transform.position - var_119_1.position).y, (manager.ui.mainCamera.transform.position - var_119_1.position).z)
				var_119_1.localEulerAngles.z = 0
				var_119_1.localEulerAngles.x = 0
				var_119_1.localEulerAngles = var_119_1.localEulerAngles

				local var_119_4 = GameObjectTools.GetOrAddComponent(var_119_1.gameObject, typeof(DynamicBoneHelper))

				if var_119_4 then
					var_119_4:EnableDynamicBone(true)
				end
			end

			local var_119_5 = 0
			local var_119_6 = 0.65

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_7 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(107081029).content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 26 <= 0 and var_119_6 or var_119_6 * (utf8.len(var_119_7) / 26)

				if (26 <= 0 and var_119_6 or var_119_6 * (utf8.len(var_119_7) / 26)) > 0 and var_119_6 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_5 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_5
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_6, arg_116_1.talkMaxDuration)

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_5) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_5 + var_119_10 and arg_116_1.time_ < var_119_5 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play107081030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 107081030
		arg_120_1.duration_ = 2.2

		local var_120_0 = {
			ja = 1.733,
			ko = 1.133,
			zh = 1.733,
			en = 2.2
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play107081031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.175

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[93].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:GetWordFromCfg(107081030)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 7 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 7)

				if (7 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 7)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081030", "story_v_out_107081.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_107081", "107081030", "story_v_out_107081.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_107081", "107081030", "story_v_out_107081.awb")

						arg_120_1:RecordAudio("107081030", var_123_6)
						arg_120_1:RecordAudio("107081030", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_107081", "107081030", "story_v_out_107081.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_107081", "107081030", "story_v_out_107081.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play107081031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 107081031
		arg_124_1.duration_ = 2.43

		local var_124_0 = {
			ja = 1.999999999999,
			ko = 2.033,
			zh = 2.433,
			en = 1.999999999999
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
			arg_124_1.auto_ = false
		end

		function arg_124_1.playNext_(arg_126_0)
			arg_124_1.onStoryFinished_()
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1058ui_story"]) and arg_124_1.var_.characterEffect1058ui_story == nil then
				arg_124_1.var_.characterEffect1058ui_story = arg_124_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.1

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1058ui_story"]) then
				if arg_124_1.var_.characterEffect1058ui_story and not isNil(arg_124_1.actors_["1058ui_story"]) then
					arg_124_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1058ui_story"]) and arg_124_1.var_.characterEffect1058ui_story then
				arg_124_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_127_2 = arg_124_1.actors_["1058ui_story"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1058ui_story = var_127_2.localPosition
			end

			local var_127_3 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_3 then
				var_127_2.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_124_1.time_ - 0) / var_127_3)
				var_127_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_2.position).x, (manager.ui.mainCamera.transform.position - var_127_2.position).y, (manager.ui.mainCamera.transform.position - var_127_2.position).z)
				var_127_2.localEulerAngles.z = 0
				var_127_2.localEulerAngles.x = 0
				var_127_2.localEulerAngles = var_127_2.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_3 and arg_124_1.time_ < 0 + var_127_3 + arg_127_0 then
				var_127_2.localPosition = Vector3.New(0, -0.95, -5.88)
				var_127_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_2.position).x, (manager.ui.mainCamera.transform.position - var_127_2.position).y, (manager.ui.mainCamera.transform.position - var_127_2.position).z)
				var_127_2.localEulerAngles.z = 0
				var_127_2.localEulerAngles.x = 0
				var_127_2.localEulerAngles = var_127_2.localEulerAngles
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action3_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_127_4 = 0
			local var_127_5 = 0.275

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_6 = arg_124_1:GetWordFromCfg(107081031)
				local var_127_7 = arg_124_1:FormatText(var_127_6.content)

				arg_124_1.text_.text = var_127_7

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_9 = 11 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 11)

				if (11 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 11)) > 0 and var_127_5 < var_127_9 then
					arg_124_1.talkMaxDuration = var_127_9

					if var_127_9 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_4
					end
				end

				arg_124_1.text_.text = var_127_7
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107081", "107081031", "story_v_out_107081.awb") ~= 0 then
					local var_127_10 = manager.audio:GetVoiceLength("story_v_out_107081", "107081031", "story_v_out_107081.awb") / 1000

					if var_127_10 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_4
					end

					if var_127_6.prefab_name ~= "" and arg_124_1.actors_[var_127_6.prefab_name] ~= nil then
						local var_127_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_6.prefab_name].transform, "story_v_out_107081", "107081031", "story_v_out_107081.awb")

						arg_124_1:RecordAudio("107081031", var_127_11)
						arg_124_1:RecordAudio("107081031", var_127_11)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_107081", "107081031", "story_v_out_107081.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_107081", "107081031", "story_v_out_107081.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_12 = math.max(var_127_5, arg_124_1.talkMaxDuration)

			if var_127_4 <= arg_124_1.time_ and arg_124_1.time_ < var_127_4 + var_127_12 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_4) / var_127_12

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_4 + var_127_12 and arg_124_1.time_ < var_127_4 + var_127_12 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C06b"
	},
	voices = {
		"story_v_out_107081.awb"
	}
}
