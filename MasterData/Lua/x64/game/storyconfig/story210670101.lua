return {
	Play1106701001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1106701001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1106701002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST22 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22")
				var_4_0.name = "ST22"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST22 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST22

				arg_1_1.bgs_.ST22.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST22" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 1

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1106701001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 23 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 23)

				if (23 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 23)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1106701002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1106701002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1106701003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.825

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_2 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_2:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1106701002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 33 <= 0 and var_12_1 or var_12_1 * (utf8.len(var_12_3) / 33)

				if (33 <= 0 and var_12_1 or var_12_1 * (utf8.len(var_12_3) / 33)) > 0 and var_12_1 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5
					var_12_0 = var_12_0 + 0.3

					if var_12_5 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = var_12_0 + 0.3
			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 + 0.3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_6) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1106701003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 1106701003
		arg_15_1.duration_ = 9.3

		local var_15_0 = {
			zh = 4.433,
			ja = 9.3
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play1106701004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if arg_15_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_18_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_15_1.stage_.transform)

				var_18_0.name = "1019ui_story"
				var_18_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_["1019ui_story"] = var_18_0

				local var_18_1 = var_18_0:GetComponentInChildren(typeof(CharacterEffect))

				var_18_1.enabled = true

				local var_18_2 = GameObjectTools.GetOrAddComponent(var_18_0, typeof(DynamicBoneHelper))

				if var_18_2 then
					var_18_2:EnableDynamicBone(false)
				end

				arg_15_1:ShowWeapon(var_18_1.transform, false)

				arg_15_1.var_["1019ui_story" .. "Animator"] = var_18_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_15_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_15_1.var_["1019ui_story" .. "LipSync"] = var_18_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_18_3 = arg_15_1.actors_["1019ui_story"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1019ui_story = var_18_3.localPosition
			end

			local var_18_4 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 then
				var_18_3.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_15_1.time_ - 0) / var_18_4)
				var_18_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_3.position).x, (manager.ui.mainCamera.transform.position - var_18_3.position).y, (manager.ui.mainCamera.transform.position - var_18_3.position).z)
				var_18_3.localEulerAngles.z = 0
				var_18_3.localEulerAngles.x = 0
				var_18_3.localEulerAngles = var_18_3.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 then
				var_18_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_18_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_3.position).x, (manager.ui.mainCamera.transform.position - var_18_3.position).y, (manager.ui.mainCamera.transform.position - var_18_3.position).z)
				var_18_3.localEulerAngles.z = 0
				var_18_3.localEulerAngles.x = 0
				var_18_3.localEulerAngles = var_18_3.localEulerAngles
			end

			local var_18_5 = arg_15_1.actors_["1019ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.characterEffect1019ui_story == nil then
				arg_15_1.var_.characterEffect1019ui_story = var_18_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_6 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_6 and not isNil(var_18_5) then
				if arg_15_1.var_.characterEffect1019ui_story and not isNil(var_18_5) then
					arg_15_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_6 and arg_15_1.time_ < 0 + var_18_6 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.characterEffect1019ui_story then
				arg_15_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				if arg_15_1.var_.characterEffect1019ui_story == nil then
					arg_15_1.var_.characterEffect1019ui_story = arg_15_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_18_8 = arg_15_1.var_.characterEffect1019ui_story

				arg_15_1.var_.characterEffect1019ui_story.imageEffect:turnOff()

				var_18_8.interferenceEffect.enabled = true
				var_18_8.interferenceEffect.noise = 0.001
				var_18_8.interferenceEffect.simTimeScale = 1
				var_18_8.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				if arg_15_1.var_.characterEffect1019ui_story == nil then
					arg_15_1.var_.characterEffect1019ui_story = arg_15_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_15_1.var_.characterEffect1019ui_story.imageEffect:turnOn(false)
			end

			local var_18_10 = 0
			local var_18_11 = 0.55

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_10 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_12 = arg_15_1:GetWordFromCfg(1106701003)
				local var_18_13 = arg_15_1:FormatText(var_18_12.content)

				arg_15_1.text_.text = var_18_13

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_15 = 22 <= 0 and var_18_11 or var_18_11 * (utf8.len(var_18_13) / 22)

				if (22 <= 0 and var_18_11 or var_18_11 * (utf8.len(var_18_13) / 22)) > 0 and var_18_11 < var_18_15 then
					arg_15_1.talkMaxDuration = var_18_15

					if var_18_15 + var_18_10 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_15 + var_18_10
					end
				end

				arg_15_1.text_.text = var_18_13
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701003", "story_v_side_new_1106701.awb") ~= 0 then
					local var_18_16 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701003", "story_v_side_new_1106701.awb") / 1000

					if var_18_16 + var_18_10 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_16 + var_18_10
					end

					if var_18_12.prefab_name ~= "" and arg_15_1.actors_[var_18_12.prefab_name] ~= nil then
						local var_18_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_12.prefab_name].transform, "story_v_side_new_1106701", "1106701003", "story_v_side_new_1106701.awb")

						arg_15_1:RecordAudio("1106701003", var_18_17)
						arg_15_1:RecordAudio("1106701003", var_18_17)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701003", "story_v_side_new_1106701.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701003", "story_v_side_new_1106701.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_18 = math.max(var_18_11, arg_15_1.talkMaxDuration)

			if var_18_10 <= arg_15_1.time_ and arg_15_1.time_ < var_18_10 + var_18_18 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_10) / var_18_18

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_10 + var_18_18 and arg_15_1.time_ < var_18_10 + var_18_18 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play1106701004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 1106701004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play1106701005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1019ui_story"]) and arg_19_1.var_.characterEffect1019ui_story == nil then
				arg_19_1.var_.characterEffect1019ui_story = arg_19_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_0 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["1019ui_story"]) then
				if arg_19_1.var_.characterEffect1019ui_story and not isNil(arg_19_1.actors_["1019ui_story"]) then
					arg_19_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_0)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["1019ui_story"]) and arg_19_1.var_.characterEffect1019ui_story then
				arg_19_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_22_1 = 0
			local var_22_2 = 0.4

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_3 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(1106701004).content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 16 <= 0 and var_22_2 or var_22_2 * (utf8.len(var_22_3) / 16)

				if (16 <= 0 and var_22_2 or var_22_2 * (utf8.len(var_22_3) / 16)) > 0 and var_22_2 < var_22_5 then
					arg_19_1.talkMaxDuration = var_22_5

					if var_22_5 + var_22_1 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_5 + var_22_1
					end
				end

				arg_19_1.text_.text = var_22_3
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_6 = math.max(var_22_2, arg_19_1.talkMaxDuration)

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_6 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_1) / var_22_6

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_1 + var_22_6 and arg_19_1.time_ < var_22_1 + var_22_6 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play1106701005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 1106701005
		arg_23_1.duration_ = 14.77

		local var_23_0 = {
			zh = 8.1,
			ja = 14.766
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play1106701006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1019ui_story"]) and arg_23_1.var_.characterEffect1019ui_story == nil then
				arg_23_1.var_.characterEffect1019ui_story = arg_23_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1019ui_story"]) then
				if arg_23_1.var_.characterEffect1019ui_story and not isNil(arg_23_1.actors_["1019ui_story"]) then
					arg_23_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1019ui_story"]) and arg_23_1.var_.characterEffect1019ui_story then
				arg_23_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_26_2 = 0
			local var_26_3 = 1.025

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_2 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_4 = arg_23_1:GetWordFromCfg(1106701005)
				local var_26_5 = arg_23_1:FormatText(var_26_4.content)

				arg_23_1.text_.text = var_26_5

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_7 = 41 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_5) / 41)

				if (41 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_5) / 41)) > 0 and var_26_3 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_2
					end
				end

				arg_23_1.text_.text = var_26_5
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701005", "story_v_side_new_1106701.awb") ~= 0 then
					local var_26_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701005", "story_v_side_new_1106701.awb") / 1000

					if var_26_8 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_8 + var_26_2
					end

					if var_26_4.prefab_name ~= "" and arg_23_1.actors_[var_26_4.prefab_name] ~= nil then
						local var_26_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_4.prefab_name].transform, "story_v_side_new_1106701", "1106701005", "story_v_side_new_1106701.awb")

						arg_23_1:RecordAudio("1106701005", var_26_9)
						arg_23_1:RecordAudio("1106701005", var_26_9)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701005", "story_v_side_new_1106701.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701005", "story_v_side_new_1106701.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_10 = math.max(var_26_3, arg_23_1.talkMaxDuration)

			if var_26_2 <= arg_23_1.time_ and arg_23_1.time_ < var_26_2 + var_26_10 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_2) / var_26_10

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_2 + var_26_10 and arg_23_1.time_ < var_26_2 + var_26_10 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play1106701006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 1106701006
		arg_27_1.duration_ = 15.97

		local var_27_0 = {
			zh = 12.7,
			ja = 15.966
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play1106701007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_30_0 = 0
			local var_30_1 = 1.6

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_2 = arg_27_1:GetWordFromCfg(1106701006)
				local var_30_3 = arg_27_1:FormatText(var_30_2.content)

				arg_27_1.text_.text = var_30_3

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 64 <= 0 and var_30_1 or var_30_1 * (utf8.len(var_30_3) / 64)

				if (64 <= 0 and var_30_1 or var_30_1 * (utf8.len(var_30_3) / 64)) > 0 and var_30_1 < var_30_5 then
					arg_27_1.talkMaxDuration = var_30_5

					if var_30_5 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_3
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701006", "story_v_side_new_1106701.awb") ~= 0 then
					local var_30_6 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701006", "story_v_side_new_1106701.awb") / 1000

					if var_30_6 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_6 + var_30_0
					end

					if var_30_2.prefab_name ~= "" and arg_27_1.actors_[var_30_2.prefab_name] ~= nil then
						local var_30_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_2.prefab_name].transform, "story_v_side_new_1106701", "1106701006", "story_v_side_new_1106701.awb")

						arg_27_1:RecordAudio("1106701006", var_30_7)
						arg_27_1:RecordAudio("1106701006", var_30_7)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701006", "story_v_side_new_1106701.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701006", "story_v_side_new_1106701.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_8 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_8 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_8

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_8 and arg_27_1.time_ < var_30_0 + var_30_8 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play1106701007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 1106701007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play1106701008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1019ui_story"]) and arg_31_1.var_.characterEffect1019ui_story == nil then
				arg_31_1.var_.characterEffect1019ui_story = arg_31_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1019ui_story"]) then
				if arg_31_1.var_.characterEffect1019ui_story and not isNil(arg_31_1.actors_["1019ui_story"]) then
					arg_31_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_0)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1019ui_story"]) and arg_31_1.var_.characterEffect1019ui_story then
				arg_31_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_34_1 = 0
			local var_34_2 = 0.125

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_3 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(1106701007).content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 5 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 5)

				if (5 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 5)) > 0 and var_34_2 < var_34_5 then
					arg_31_1.talkMaxDuration = var_34_5

					if var_34_5 + var_34_1 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + var_34_1
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_6 = math.max(var_34_2, arg_31_1.talkMaxDuration)

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_6 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_1) / var_34_6

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_1 + var_34_6 and arg_31_1.time_ < var_34_1 + var_34_6 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play1106701008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 1106701008
		arg_35_1.duration_ = 5.73

		local var_35_0 = {
			zh = 3.566,
			ja = 5.733
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play1106701009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1019ui_story"]) and arg_35_1.var_.characterEffect1019ui_story == nil then
				arg_35_1.var_.characterEffect1019ui_story = arg_35_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1019ui_story"]) then
				if arg_35_1.var_.characterEffect1019ui_story and not isNil(arg_35_1.actors_["1019ui_story"]) then
					arg_35_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1019ui_story"]) and arg_35_1.var_.characterEffect1019ui_story then
				arg_35_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_38_2 = 0
			local var_38_3 = 0.375

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_4 = arg_35_1:GetWordFromCfg(1106701008)
				local var_38_5 = arg_35_1:FormatText(var_38_4.content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 15 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_5) / 15)

				if (15 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_5) / 15)) > 0 and var_38_3 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_2
					end
				end

				arg_35_1.text_.text = var_38_5
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701008", "story_v_side_new_1106701.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701008", "story_v_side_new_1106701.awb") / 1000

					if var_38_8 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_2
					end

					if var_38_4.prefab_name ~= "" and arg_35_1.actors_[var_38_4.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_4.prefab_name].transform, "story_v_side_new_1106701", "1106701008", "story_v_side_new_1106701.awb")

						arg_35_1:RecordAudio("1106701008", var_38_9)
						arg_35_1:RecordAudio("1106701008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701008", "story_v_side_new_1106701.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701008", "story_v_side_new_1106701.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_3, arg_35_1.talkMaxDuration)

			if var_38_2 <= arg_35_1.time_ and arg_35_1.time_ < var_38_2 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_2) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_2 + var_38_10 and arg_35_1.time_ < var_38_2 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play1106701009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 1106701009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play1106701010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1019ui_story"]) and arg_39_1.var_.characterEffect1019ui_story == nil then
				arg_39_1.var_.characterEffect1019ui_story = arg_39_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1019ui_story"]) then
				if arg_39_1.var_.characterEffect1019ui_story and not isNil(arg_39_1.actors_["1019ui_story"]) then
					arg_39_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1019ui_story"]) and arg_39_1.var_.characterEffect1019ui_story then
				arg_39_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 0.15

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(1106701009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 6 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 6)

				if (6 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 6)) > 0 and var_42_2 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_6 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_6

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_6 and arg_39_1.time_ < var_42_1 + var_42_6 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play1106701010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1106701010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play1106701011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1019ui_story = arg_43_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1019ui_story"].transform.position).z)
				arg_43_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1019ui_story"].transform.localEulerAngles = arg_43_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1019ui_story"].transform.position).z)
				arg_43_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1019ui_story"].transform.localEulerAngles = arg_43_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_46_1 = 0
			local var_46_2 = 1.05

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(1106701010).content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 42 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 42)

				if (42 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 42)) > 0 and var_46_2 < var_46_5 then
					arg_43_1.talkMaxDuration = var_46_5

					if var_46_5 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_6 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_6 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_6

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_6 and arg_43_1.time_ < var_46_1 + var_46_6 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play1106701011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1106701011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1106701012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.15

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(1106701011).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 6 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 6)

				if (6 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 6)) > 0 and var_50_0 < var_50_3 then
					arg_47_1.talkMaxDuration = var_50_3

					if var_50_3 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_3 + 0
					end
				end

				arg_47_1.text_.text = var_50_1
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_4 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_4

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play1106701012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1106701012
		arg_51_1.duration_ = 10.27

		local var_51_0 = {
			zh = 4.333,
			ja = 10.266
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1106701013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if arg_51_1.actors_["6046_story"] == nil and not isNil((Asset.Load("Char/" .. "6046_story"))) then
				local var_54_0 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_51_1.stage_.transform)

				var_54_0.name = "6046_story"
				var_54_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["6046_story"] = var_54_0

				local var_54_1 = var_54_0:GetComponentInChildren(typeof(CharacterEffect))

				var_54_1.enabled = true

				local var_54_2 = GameObjectTools.GetOrAddComponent(var_54_0, typeof(DynamicBoneHelper))

				if var_54_2 then
					var_54_2:EnableDynamicBone(false)
				end

				arg_51_1:ShowWeapon(var_54_1.transform, false)

				arg_51_1.var_["6046_story" .. "Animator"] = var_54_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_51_1.var_["6046_story" .. "Animator"].applyRootMotion = true
				arg_51_1.var_["6046_story" .. "LipSync"] = var_54_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_54_3 = arg_51_1.actors_["6046_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos6046_story = var_54_3.localPosition

				local var_54_4 = GameObjectTools.GetOrAddComponent(var_54_3.gameObject, typeof(DynamicBoneHelper))

				if var_54_4 then
					var_54_4:EnableDynamicBone(false)
				end
			end

			local var_54_5 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_5 then
				var_54_3.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_51_1.time_ - 0) / var_54_5)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_5 and arg_51_1.time_ < 0 + var_54_5 + arg_54_0 then
				var_54_3.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles

				local var_54_6 = GameObjectTools.GetOrAddComponent(var_54_3.gameObject, typeof(DynamicBoneHelper))

				if var_54_6 then
					var_54_6:EnableDynamicBone(true)
				end
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_54_7 = arg_51_1.actors_["6046_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_7) and arg_51_1.var_.characterEffect6046_story == nil then
				arg_51_1.var_.characterEffect6046_story = var_54_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_8 = 0.034

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_8 and not isNil(var_54_7) then
				if arg_51_1.var_.characterEffect6046_story and not isNil(var_54_7) then
					arg_51_1.var_.characterEffect6046_story.fillFlat = true
					arg_51_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_8)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_8 and arg_51_1.time_ < 0 + var_54_8 + arg_54_0 and not isNil(var_54_7) and arg_51_1.var_.characterEffect6046_story then
				arg_51_1.var_.characterEffect6046_story.fillFlat = true
				arg_51_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_54_9 = "6045_story"

			if arg_51_1.actors_["6045_story"] == nil and not isNil((Asset.Load("Char/" .. "6045_story"))) then
				local var_54_10 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_51_1.stage_.transform)

				var_54_10.name = var_54_9
				var_54_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_[var_54_9] = var_54_10

				local var_54_11 = var_54_10:GetComponentInChildren(typeof(CharacterEffect))

				var_54_11.enabled = true

				local var_54_12 = GameObjectTools.GetOrAddComponent(var_54_10, typeof(DynamicBoneHelper))

				if var_54_12 then
					var_54_12:EnableDynamicBone(false)
				end

				arg_51_1:ShowWeapon(var_54_11.transform, false)

				arg_51_1.var_[var_54_9 .. "Animator"] = var_54_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_51_1.var_[var_54_9 .. "Animator"].applyRootMotion = true
				arg_51_1.var_[var_54_9 .. "LipSync"] = var_54_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_54_13 = arg_51_1.actors_["6045_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos6045_story = var_54_13.localPosition

				local var_54_14 = GameObjectTools.GetOrAddComponent(var_54_13.gameObject, typeof(DynamicBoneHelper))

				if var_54_14 then
					var_54_14:EnableDynamicBone(false)
				end
			end

			local var_54_15 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_15 then
				var_54_13.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_51_1.time_ - 0) / var_54_15)
				var_54_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_13.position).x, (manager.ui.mainCamera.transform.position - var_54_13.position).y, (manager.ui.mainCamera.transform.position - var_54_13.position).z)
				var_54_13.localEulerAngles.z = 0
				var_54_13.localEulerAngles.x = 0
				var_54_13.localEulerAngles = var_54_13.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_15 and arg_51_1.time_ < 0 + var_54_15 + arg_54_0 then
				var_54_13.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_54_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_13.position).x, (manager.ui.mainCamera.transform.position - var_54_13.position).y, (manager.ui.mainCamera.transform.position - var_54_13.position).z)
				var_54_13.localEulerAngles.z = 0
				var_54_13.localEulerAngles.x = 0
				var_54_13.localEulerAngles = var_54_13.localEulerAngles

				local var_54_16 = GameObjectTools.GetOrAddComponent(var_54_13.gameObject, typeof(DynamicBoneHelper))

				if var_54_16 then
					var_54_16:EnableDynamicBone(true)
				end
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_54_17 = arg_51_1.actors_["6045_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_17) and arg_51_1.var_.characterEffect6045_story == nil then
				arg_51_1.var_.characterEffect6045_story = var_54_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_18 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_18 and not isNil(var_54_17) then
				if arg_51_1.var_.characterEffect6045_story and not isNil(var_54_17) then
					arg_51_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_18 and arg_51_1.time_ < 0 + var_54_18 + arg_54_0 and not isNil(var_54_17) and arg_51_1.var_.characterEffect6045_story then
				arg_51_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_54_20 = 0
			local var_54_21 = 0.35

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_20 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_22 = arg_51_1:GetWordFromCfg(1106701012)
				local var_54_23 = arg_51_1:FormatText(var_54_22.content)

				arg_51_1.text_.text = var_54_23

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_25 = 14 <= 0 and var_54_21 or var_54_21 * (utf8.len(var_54_23) / 14)

				if (14 <= 0 and var_54_21 or var_54_21 * (utf8.len(var_54_23) / 14)) > 0 and var_54_21 < var_54_25 then
					arg_51_1.talkMaxDuration = var_54_25

					if var_54_25 + var_54_20 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_25 + var_54_20
					end
				end

				arg_51_1.text_.text = var_54_23
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701012", "story_v_side_new_1106701.awb") ~= 0 then
					local var_54_26 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701012", "story_v_side_new_1106701.awb") / 1000

					if var_54_26 + var_54_20 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_26 + var_54_20
					end

					if var_54_22.prefab_name ~= "" and arg_51_1.actors_[var_54_22.prefab_name] ~= nil then
						local var_54_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_22.prefab_name].transform, "story_v_side_new_1106701", "1106701012", "story_v_side_new_1106701.awb")

						arg_51_1:RecordAudio("1106701012", var_54_27)
						arg_51_1:RecordAudio("1106701012", var_54_27)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701012", "story_v_side_new_1106701.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701012", "story_v_side_new_1106701.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_28 = math.max(var_54_21, arg_51_1.talkMaxDuration)

			if var_54_20 <= arg_51_1.time_ and arg_51_1.time_ < var_54_20 + var_54_28 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_20) / var_54_28

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_20 + var_54_28 and arg_51_1.time_ < var_54_20 + var_54_28 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play1106701013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1106701013
		arg_55_1.duration_ = 2.63

		local var_55_0 = {
			zh = 2.633,
			ja = 1.999999999999
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1106701014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["6046_story"]) and arg_55_1.var_.characterEffect6046_story == nil then
				arg_55_1.var_.characterEffect6046_story = arg_55_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["6046_story"]) then
				if arg_55_1.var_.characterEffect6046_story and not isNil(arg_55_1.actors_["6046_story"]) then
					arg_55_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["6046_story"]) and arg_55_1.var_.characterEffect6046_story then
				arg_55_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_58_2 = arg_55_1.actors_["6045_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect6045_story == nil then
				arg_55_1.var_.characterEffect6045_story = var_58_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_3 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.characterEffect6045_story and not isNil(var_58_2) then
					arg_55_1.var_.characterEffect6045_story.fillFlat = true
					arg_55_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_3)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect6045_story then
				arg_55_1.var_.characterEffect6045_story.fillFlat = true
				arg_55_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_58_4 = 0
			local var_58_5 = 0.25

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(1106701013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 10 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 10)

				if (10 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 10)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701013", "story_v_side_new_1106701.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701013", "story_v_side_new_1106701.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_side_new_1106701", "1106701013", "story_v_side_new_1106701.awb")

						arg_55_1:RecordAudio("1106701013", var_58_11)
						arg_55_1:RecordAudio("1106701013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701013", "story_v_side_new_1106701.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701013", "story_v_side_new_1106701.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1106701014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1106701014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1106701015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["6046_story"]) and arg_59_1.var_.characterEffect6046_story == nil then
				arg_59_1.var_.characterEffect6046_story = arg_59_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["6046_story"]) then
				if arg_59_1.var_.characterEffect6046_story and not isNil(arg_59_1.actors_["6046_story"]) then
					arg_59_1.var_.characterEffect6046_story.fillFlat = true
					arg_59_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["6046_story"]) and arg_59_1.var_.characterEffect6046_story then
				arg_59_1.var_.characterEffect6046_story.fillFlat = true
				arg_59_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_62_1 = 0
			local var_62_2 = 0.05

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(1106701014).content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 2 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 2)

				if (2 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 2)) > 0 and var_62_2 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_6 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_6 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_6

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_6 and arg_59_1.time_ < var_62_1 + var_62_6 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play1106701015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1106701015
		arg_63_1.duration_ = 10.27

		local var_63_0 = {
			zh = 3.666,
			ja = 10.266
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1106701016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if arg_63_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_66_0 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_63_1.stage_.transform)

				var_66_0.name = "1042ui_story"
				var_66_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.actors_["1042ui_story"] = var_66_0

				local var_66_1 = var_66_0:GetComponentInChildren(typeof(CharacterEffect))

				var_66_1.enabled = true

				local var_66_2 = GameObjectTools.GetOrAddComponent(var_66_0, typeof(DynamicBoneHelper))

				if var_66_2 then
					var_66_2:EnableDynamicBone(false)
				end

				arg_63_1:ShowWeapon(var_66_1.transform, false)

				arg_63_1.var_["1042ui_story" .. "Animator"] = var_66_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_63_1.var_["1042ui_story" .. "Animator"].applyRootMotion = true
				arg_63_1.var_["1042ui_story" .. "LipSync"] = var_66_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_66_3 = arg_63_1.actors_["1042ui_story"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1042ui_story = var_66_3.localPosition
			end

			local var_66_4 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				var_66_3.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_63_1.time_ - 0) / var_66_4)
				var_66_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_3.position).x, (manager.ui.mainCamera.transform.position - var_66_3.position).y, (manager.ui.mainCamera.transform.position - var_66_3.position).z)
				var_66_3.localEulerAngles.z = 0
				var_66_3.localEulerAngles.x = 0
				var_66_3.localEulerAngles = var_66_3.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				var_66_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_66_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_3.position).x, (manager.ui.mainCamera.transform.position - var_66_3.position).y, (manager.ui.mainCamera.transform.position - var_66_3.position).z)
				var_66_3.localEulerAngles.z = 0
				var_66_3.localEulerAngles.x = 0
				var_66_3.localEulerAngles = var_66_3.localEulerAngles
			end

			local var_66_5 = arg_63_1.actors_["6046_story"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos6046_story = var_66_5.localPosition

				local var_66_6 = GameObjectTools.GetOrAddComponent(var_66_5.gameObject, typeof(DynamicBoneHelper))

				if var_66_6 then
					var_66_6:EnableDynamicBone(false)
				end
			end

			local var_66_7 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				var_66_5.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_63_1.time_ - 0) / var_66_7)
				var_66_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_5.position).x, (manager.ui.mainCamera.transform.position - var_66_5.position).y, (manager.ui.mainCamera.transform.position - var_66_5.position).z)
				var_66_5.localEulerAngles.z = 0
				var_66_5.localEulerAngles.x = 0
				var_66_5.localEulerAngles = var_66_5.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				var_66_5.localPosition = Vector3.New(0, 100, 0)
				var_66_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_5.position).x, (manager.ui.mainCamera.transform.position - var_66_5.position).y, (manager.ui.mainCamera.transform.position - var_66_5.position).z)
				var_66_5.localEulerAngles.z = 0
				var_66_5.localEulerAngles.x = 0
				var_66_5.localEulerAngles = var_66_5.localEulerAngles

				local var_66_8 = GameObjectTools.GetOrAddComponent(var_66_5.gameObject, typeof(DynamicBoneHelper))

				if var_66_8 then
					var_66_8:EnableDynamicBone(true)
				end
			end

			local var_66_9 = arg_63_1.actors_["6045_story"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos6045_story = var_66_9.localPosition

				local var_66_10 = GameObjectTools.GetOrAddComponent(var_66_9.gameObject, typeof(DynamicBoneHelper))

				if var_66_10 then
					var_66_10:EnableDynamicBone(false)
				end
			end

			local var_66_11 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_11 then
				var_66_9.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_63_1.time_ - 0) / var_66_11)
				var_66_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_9.position).x, (manager.ui.mainCamera.transform.position - var_66_9.position).y, (manager.ui.mainCamera.transform.position - var_66_9.position).z)
				var_66_9.localEulerAngles.z = 0
				var_66_9.localEulerAngles.x = 0
				var_66_9.localEulerAngles = var_66_9.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_11 and arg_63_1.time_ < 0 + var_66_11 + arg_66_0 then
				var_66_9.localPosition = Vector3.New(0, 100, 0)
				var_66_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_9.position).x, (manager.ui.mainCamera.transform.position - var_66_9.position).y, (manager.ui.mainCamera.transform.position - var_66_9.position).z)
				var_66_9.localEulerAngles.z = 0
				var_66_9.localEulerAngles.x = 0
				var_66_9.localEulerAngles = var_66_9.localEulerAngles

				local var_66_12 = GameObjectTools.GetOrAddComponent(var_66_9.gameObject, typeof(DynamicBoneHelper))

				if var_66_12 then
					var_66_12:EnableDynamicBone(true)
				end
			end

			local var_66_13 = arg_63_1.actors_["1042ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_13) and arg_63_1.var_.characterEffect1042ui_story == nil then
				arg_63_1.var_.characterEffect1042ui_story = var_66_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_14 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_14 and not isNil(var_66_13) then
				if arg_63_1.var_.characterEffect1042ui_story and not isNil(var_66_13) then
					arg_63_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_14 and arg_63_1.time_ < 0 + var_66_14 + arg_66_0 and not isNil(var_66_13) and arg_63_1.var_.characterEffect1042ui_story then
				arg_63_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_66_16 = 0
			local var_66_17 = 0.4

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_18 = arg_63_1:GetWordFromCfg(1106701015)
				local var_66_19 = arg_63_1:FormatText(var_66_18.content)

				arg_63_1.text_.text = var_66_19

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_21 = 16 <= 0 and var_66_17 or var_66_17 * (utf8.len(var_66_19) / 16)

				if (16 <= 0 and var_66_17 or var_66_17 * (utf8.len(var_66_19) / 16)) > 0 and var_66_17 < var_66_21 then
					arg_63_1.talkMaxDuration = var_66_21

					if var_66_21 + var_66_16 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_21 + var_66_16
					end
				end

				arg_63_1.text_.text = var_66_19
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701015", "story_v_side_new_1106701.awb") ~= 0 then
					local var_66_22 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701015", "story_v_side_new_1106701.awb") / 1000

					if var_66_22 + var_66_16 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_22 + var_66_16
					end

					if var_66_18.prefab_name ~= "" and arg_63_1.actors_[var_66_18.prefab_name] ~= nil then
						local var_66_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_18.prefab_name].transform, "story_v_side_new_1106701", "1106701015", "story_v_side_new_1106701.awb")

						arg_63_1:RecordAudio("1106701015", var_66_23)
						arg_63_1:RecordAudio("1106701015", var_66_23)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701015", "story_v_side_new_1106701.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701015", "story_v_side_new_1106701.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_24 = math.max(var_66_17, arg_63_1.talkMaxDuration)

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_24 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_16) / var_66_24

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_16 + var_66_24 and arg_63_1.time_ < var_66_16 + var_66_24 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play1106701016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1106701016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1106701017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1042ui_story"]) and arg_67_1.var_.characterEffect1042ui_story == nil then
				arg_67_1.var_.characterEffect1042ui_story = arg_67_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1042ui_story"]) then
				if arg_67_1.var_.characterEffect1042ui_story and not isNil(arg_67_1.actors_["1042ui_story"]) then
					arg_67_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1042ui_story"]) and arg_67_1.var_.characterEffect1042ui_story then
				arg_67_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_70_1 = 0
			local var_70_2 = 0.975

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(1106701016).content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 39 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 39)

				if (39 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 39)) > 0 and var_70_2 < var_70_5 then
					arg_67_1.talkMaxDuration = var_70_5

					if var_70_5 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_6 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_6 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_6

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_6 and arg_67_1.time_ < var_70_1 + var_70_6 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1106701017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1106701017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1106701018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.2

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(1106701017).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 8 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 8)

				if (8 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 8)) > 0 and var_74_0 < var_74_3 then
					arg_71_1.talkMaxDuration = var_74_3

					if var_74_3 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_3 + 0
					end
				end

				arg_71_1.text_.text = var_74_1
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_4 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_4

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play1106701018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1106701018
		arg_75_1.duration_ = 6.73

		local var_75_0 = {
			zh = 5.733,
			ja = 6.733
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1106701019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1042ui_story"]) and arg_75_1.var_.characterEffect1042ui_story == nil then
				arg_75_1.var_.characterEffect1042ui_story = arg_75_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1042ui_story"]) then
				if arg_75_1.var_.characterEffect1042ui_story and not isNil(arg_75_1.actors_["1042ui_story"]) then
					arg_75_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1042ui_story"]) and arg_75_1.var_.characterEffect1042ui_story then
				arg_75_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_78_2 = 0
			local var_78_3 = 0.6

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_4 = arg_75_1:GetWordFromCfg(1106701018)
				local var_78_5 = arg_75_1:FormatText(var_78_4.content)

				arg_75_1.text_.text = var_78_5

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_7 = 24 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_5) / 24)

				if (24 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_5) / 24)) > 0 and var_78_3 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_2
					end
				end

				arg_75_1.text_.text = var_78_5
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701018", "story_v_side_new_1106701.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701018", "story_v_side_new_1106701.awb") / 1000

					if var_78_8 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_2
					end

					if var_78_4.prefab_name ~= "" and arg_75_1.actors_[var_78_4.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_4.prefab_name].transform, "story_v_side_new_1106701", "1106701018", "story_v_side_new_1106701.awb")

						arg_75_1:RecordAudio("1106701018", var_78_9)
						arg_75_1:RecordAudio("1106701018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701018", "story_v_side_new_1106701.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701018", "story_v_side_new_1106701.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_3, arg_75_1.talkMaxDuration)

			if var_78_2 <= arg_75_1.time_ and arg_75_1.time_ < var_78_2 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_2) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_2 + var_78_10 and arg_75_1.time_ < var_78_2 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1106701019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1106701019
		arg_79_1.duration_ = 5.8

		local var_79_0 = {
			zh = 4.766,
			ja = 5.8
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1106701020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action3_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_82_0 = 0
			local var_82_1 = 0.625

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_2 = arg_79_1:GetWordFromCfg(1106701019)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 25 <= 0 and var_82_1 or var_82_1 * (utf8.len(var_82_3) / 25)

				if (25 <= 0 and var_82_1 or var_82_1 * (utf8.len(var_82_3) / 25)) > 0 and var_82_1 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701019", "story_v_side_new_1106701.awb") ~= 0 then
					local var_82_6 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701019", "story_v_side_new_1106701.awb") / 1000

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end

					if var_82_2.prefab_name ~= "" and arg_79_1.actors_[var_82_2.prefab_name] ~= nil then
						local var_82_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_2.prefab_name].transform, "story_v_side_new_1106701", "1106701019", "story_v_side_new_1106701.awb")

						arg_79_1:RecordAudio("1106701019", var_82_7)
						arg_79_1:RecordAudio("1106701019", var_82_7)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701019", "story_v_side_new_1106701.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701019", "story_v_side_new_1106701.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_8 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_8

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_8 and arg_79_1.time_ < var_82_0 + var_82_8 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1106701020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1106701020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1106701021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1042ui_story"]) and arg_83_1.var_.characterEffect1042ui_story == nil then
				arg_83_1.var_.characterEffect1042ui_story = arg_83_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1042ui_story"]) then
				if arg_83_1.var_.characterEffect1042ui_story and not isNil(arg_83_1.actors_["1042ui_story"]) then
					arg_83_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1042ui_story"]) and arg_83_1.var_.characterEffect1042ui_story then
				arg_83_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.25

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(1106701020).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 10 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 10)

				if (10 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 10)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1106701021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1106701021
		arg_87_1.duration_ = 4.83

		local var_87_0 = {
			zh = 4.833,
			ja = 2.333
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1106701022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1042ui_story"]) and arg_87_1.var_.characterEffect1042ui_story == nil then
				arg_87_1.var_.characterEffect1042ui_story = arg_87_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1042ui_story"]) then
				if arg_87_1.var_.characterEffect1042ui_story and not isNil(arg_87_1.actors_["1042ui_story"]) then
					arg_87_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1042ui_story"]) and arg_87_1.var_.characterEffect1042ui_story then
				arg_87_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action438")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_90_2 = 0
			local var_90_3 = 0.45

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_4 = arg_87_1:GetWordFromCfg(1106701021)
				local var_90_5 = arg_87_1:FormatText(var_90_4.content)

				arg_87_1.text_.text = var_90_5

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_7 = 18 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 18)

				if (18 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 18)) > 0 and var_90_3 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_2
					end
				end

				arg_87_1.text_.text = var_90_5
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701021", "story_v_side_new_1106701.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701021", "story_v_side_new_1106701.awb") / 1000

					if var_90_8 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_2
					end

					if var_90_4.prefab_name ~= "" and arg_87_1.actors_[var_90_4.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_4.prefab_name].transform, "story_v_side_new_1106701", "1106701021", "story_v_side_new_1106701.awb")

						arg_87_1:RecordAudio("1106701021", var_90_9)
						arg_87_1:RecordAudio("1106701021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701021", "story_v_side_new_1106701.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701021", "story_v_side_new_1106701.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_3, arg_87_1.talkMaxDuration)

			if var_90_2 <= arg_87_1.time_ and arg_87_1.time_ < var_90_2 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_2) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_2 + var_90_10 and arg_87_1.time_ < var_90_2 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play1106701022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1106701022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1106701023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1042ui_story"]) and arg_91_1.var_.characterEffect1042ui_story == nil then
				arg_91_1.var_.characterEffect1042ui_story = arg_91_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1042ui_story"]) then
				if arg_91_1.var_.characterEffect1042ui_story and not isNil(arg_91_1.actors_["1042ui_story"]) then
					arg_91_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_0)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1042ui_story"]) and arg_91_1.var_.characterEffect1042ui_story then
				arg_91_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_94_1 = 0
			local var_94_2 = 0.75

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(1106701022).content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 30 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 30)

				if (30 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 30)) > 0 and var_94_2 < var_94_5 then
					arg_91_1.talkMaxDuration = var_94_5

					if var_94_5 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_6 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_6 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_6

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_6 and arg_91_1.time_ < var_94_1 + var_94_6 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1106701023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1106701023
		arg_95_1.duration_ = 3.67

		local var_95_0 = {
			zh = 1.999999999999,
			ja = 3.666
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1106701024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1042ui_story"]) and arg_95_1.var_.characterEffect1042ui_story == nil then
				arg_95_1.var_.characterEffect1042ui_story = arg_95_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1042ui_story"]) then
				if arg_95_1.var_.characterEffect1042ui_story and not isNil(arg_95_1.actors_["1042ui_story"]) then
					arg_95_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1042ui_story"]) and arg_95_1.var_.characterEffect1042ui_story then
				arg_95_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action484")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_98_2 = 0
			local var_98_3 = 0.125

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_4 = arg_95_1:GetWordFromCfg(1106701023)
				local var_98_5 = arg_95_1:FormatText(var_98_4.content)

				arg_95_1.text_.text = var_98_5

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_7 = 5 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_5) / 5)

				if (5 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_5) / 5)) > 0 and var_98_3 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_2
					end
				end

				arg_95_1.text_.text = var_98_5
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701023", "story_v_side_new_1106701.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701023", "story_v_side_new_1106701.awb") / 1000

					if var_98_8 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_2
					end

					if var_98_4.prefab_name ~= "" and arg_95_1.actors_[var_98_4.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_4.prefab_name].transform, "story_v_side_new_1106701", "1106701023", "story_v_side_new_1106701.awb")

						arg_95_1:RecordAudio("1106701023", var_98_9)
						arg_95_1:RecordAudio("1106701023", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701023", "story_v_side_new_1106701.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701023", "story_v_side_new_1106701.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_3, arg_95_1.talkMaxDuration)

			if var_98_2 <= arg_95_1.time_ and arg_95_1.time_ < var_98_2 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_2) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_2 + var_98_10 and arg_95_1.time_ < var_98_2 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1106701024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1106701024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1106701025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1042ui_story"]) and arg_99_1.var_.characterEffect1042ui_story == nil then
				arg_99_1.var_.characterEffect1042ui_story = arg_99_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1042ui_story"]) then
				if arg_99_1.var_.characterEffect1042ui_story and not isNil(arg_99_1.actors_["1042ui_story"]) then
					arg_99_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_0)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1042ui_story"]) and arg_99_1.var_.characterEffect1042ui_story then
				arg_99_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_102_1 = 0
			local var_102_2 = 1.1

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1106701024).content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 44 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 44)

				if (44 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 44)) > 0 and var_102_2 < var_102_5 then
					arg_99_1.talkMaxDuration = var_102_5

					if var_102_5 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + var_102_1
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_6 = math.max(var_102_2, arg_99_1.talkMaxDuration)

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_6 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_1) / var_102_6

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_1 + var_102_6 and arg_99_1.time_ < var_102_1 + var_102_6 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1106701025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1106701025
		arg_103_1.duration_ = 9.3

		local var_103_0 = {
			zh = 8.666,
			ja = 9.3
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1106701026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1042ui_story"]) and arg_103_1.var_.characterEffect1042ui_story == nil then
				arg_103_1.var_.characterEffect1042ui_story = arg_103_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1042ui_story"]) then
				if arg_103_1.var_.characterEffect1042ui_story and not isNil(arg_103_1.actors_["1042ui_story"]) then
					arg_103_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1042ui_story"]) and arg_103_1.var_.characterEffect1042ui_story then
				arg_103_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_106_2 = 0
			local var_106_3 = 0.7

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_4 = arg_103_1:GetWordFromCfg(1106701025)
				local var_106_5 = arg_103_1:FormatText(var_106_4.content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 28 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 28)

				if (28 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 28)) > 0 and var_106_3 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_2
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701025", "story_v_side_new_1106701.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701025", "story_v_side_new_1106701.awb") / 1000

					if var_106_8 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_2
					end

					if var_106_4.prefab_name ~= "" and arg_103_1.actors_[var_106_4.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_4.prefab_name].transform, "story_v_side_new_1106701", "1106701025", "story_v_side_new_1106701.awb")

						arg_103_1:RecordAudio("1106701025", var_106_9)
						arg_103_1:RecordAudio("1106701025", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701025", "story_v_side_new_1106701.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701025", "story_v_side_new_1106701.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_3, arg_103_1.talkMaxDuration)

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_2) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_2 + var_106_10 and arg_103_1.time_ < var_106_2 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1106701026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1106701026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1106701027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1042ui_story"]) and arg_107_1.var_.characterEffect1042ui_story == nil then
				arg_107_1.var_.characterEffect1042ui_story = arg_107_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1042ui_story"]) then
				if arg_107_1.var_.characterEffect1042ui_story and not isNil(arg_107_1.actors_["1042ui_story"]) then
					arg_107_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1042ui_story"]) and arg_107_1.var_.characterEffect1042ui_story then
				arg_107_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_110_1 = 0
			local var_110_2 = 0.075

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(1106701026).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 3 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 3)

				if (3 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 3)) > 0 and var_110_2 < var_110_5 then
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
	Play1106701027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1106701027
		arg_111_1.duration_ = 13.27

		local var_111_0 = {
			zh = 7.866,
			ja = 13.266
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
				arg_111_0:Play1106701028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1042ui_story"]) and arg_111_1.var_.characterEffect1042ui_story == nil then
				arg_111_1.var_.characterEffect1042ui_story = arg_111_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1042ui_story"]) then
				if arg_111_1.var_.characterEffect1042ui_story and not isNil(arg_111_1.actors_["1042ui_story"]) then
					arg_111_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1042ui_story"]) and arg_111_1.var_.characterEffect1042ui_story then
				arg_111_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action442")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_114_2 = 0
			local var_114_3 = 0.8

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_4 = arg_111_1:GetWordFromCfg(1106701027)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 32 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 32)

				if (32 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 32)) > 0 and var_114_3 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701027", "story_v_side_new_1106701.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701027", "story_v_side_new_1106701.awb") / 1000

					if var_114_8 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_2
					end

					if var_114_4.prefab_name ~= "" and arg_111_1.actors_[var_114_4.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_4.prefab_name].transform, "story_v_side_new_1106701", "1106701027", "story_v_side_new_1106701.awb")

						arg_111_1:RecordAudio("1106701027", var_114_9)
						arg_111_1:RecordAudio("1106701027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701027", "story_v_side_new_1106701.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701027", "story_v_side_new_1106701.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_10 and arg_111_1.time_ < var_114_2 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1106701028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1106701028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1106701029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1042ui_story"]) and arg_115_1.var_.characterEffect1042ui_story == nil then
				arg_115_1.var_.characterEffect1042ui_story = arg_115_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1042ui_story"]) then
				if arg_115_1.var_.characterEffect1042ui_story and not isNil(arg_115_1.actors_["1042ui_story"]) then
					arg_115_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_0)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1042ui_story"]) and arg_115_1.var_.characterEffect1042ui_story then
				arg_115_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_118_1 = 0
			local var_118_2 = 0.075

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_3 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(1106701028).content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 3 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 3)

				if (3 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 3)) > 0 and var_118_2 < var_118_5 then
					arg_115_1.talkMaxDuration = var_118_5

					if var_118_5 + var_118_1 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + var_118_1
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_6 = math.max(var_118_2, arg_115_1.talkMaxDuration)

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_6 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_1) / var_118_6

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_1 + var_118_6 and arg_115_1.time_ < var_118_1 + var_118_6 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play1106701029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1106701029
		arg_119_1.duration_ = 10.37

		local var_119_0 = {
			zh = 8.133,
			ja = 10.366
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1106701030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1042ui_story"]) and arg_119_1.var_.characterEffect1042ui_story == nil then
				arg_119_1.var_.characterEffect1042ui_story = arg_119_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1042ui_story"]) then
				if arg_119_1.var_.characterEffect1042ui_story and not isNil(arg_119_1.actors_["1042ui_story"]) then
					arg_119_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1042ui_story"]) and arg_119_1.var_.characterEffect1042ui_story then
				arg_119_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_122_2 = 0
			local var_122_3 = 0.85

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_4 = arg_119_1:GetWordFromCfg(1106701029)
				local var_122_5 = arg_119_1:FormatText(var_122_4.content)

				arg_119_1.text_.text = var_122_5

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_7 = 34 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 34)

				if (34 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 34)) > 0 and var_122_3 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_2
					end
				end

				arg_119_1.text_.text = var_122_5
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701029", "story_v_side_new_1106701.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701029", "story_v_side_new_1106701.awb") / 1000

					if var_122_8 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_2
					end

					if var_122_4.prefab_name ~= "" and arg_119_1.actors_[var_122_4.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_4.prefab_name].transform, "story_v_side_new_1106701", "1106701029", "story_v_side_new_1106701.awb")

						arg_119_1:RecordAudio("1106701029", var_122_9)
						arg_119_1:RecordAudio("1106701029", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701029", "story_v_side_new_1106701.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701029", "story_v_side_new_1106701.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_3, arg_119_1.talkMaxDuration)

			if var_122_2 <= arg_119_1.time_ and arg_119_1.time_ < var_122_2 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_2) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_2 + var_122_10 and arg_119_1.time_ < var_122_2 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1106701030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1106701030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1106701031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1042ui_story"]) and arg_123_1.var_.characterEffect1042ui_story == nil then
				arg_123_1.var_.characterEffect1042ui_story = arg_123_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1042ui_story"]) then
				if arg_123_1.var_.characterEffect1042ui_story and not isNil(arg_123_1.actors_["1042ui_story"]) then
					arg_123_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_0)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1042ui_story"]) and arg_123_1.var_.characterEffect1042ui_story then
				arg_123_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_126_1 = 0
			local var_126_2 = 0.075

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(1106701030).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 3 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 3)

				if (3 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 3)) > 0 and var_126_2 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_6 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_6 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_6

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_6 and arg_123_1.time_ < var_126_1 + var_126_6 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1106701031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1106701031
		arg_127_1.duration_ = 7.5

		local var_127_0 = {
			zh = 5.5,
			ja = 7.5
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1106701032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1042ui_story"]) and arg_127_1.var_.characterEffect1042ui_story == nil then
				arg_127_1.var_.characterEffect1042ui_story = arg_127_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1042ui_story"]) then
				if arg_127_1.var_.characterEffect1042ui_story and not isNil(arg_127_1.actors_["1042ui_story"]) then
					arg_127_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1042ui_story"]) and arg_127_1.var_.characterEffect1042ui_story then
				arg_127_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_130_2 = 0
			local var_130_3 = 0.5

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_4 = arg_127_1:GetWordFromCfg(1106701031)
				local var_130_5 = arg_127_1:FormatText(var_130_4.content)

				arg_127_1.text_.text = var_130_5

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_7 = 20 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_5) / 20)

				if (20 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_5) / 20)) > 0 and var_130_3 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_2
					end
				end

				arg_127_1.text_.text = var_130_5
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701031", "story_v_side_new_1106701.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701031", "story_v_side_new_1106701.awb") / 1000

					if var_130_8 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_2
					end

					if var_130_4.prefab_name ~= "" and arg_127_1.actors_[var_130_4.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_4.prefab_name].transform, "story_v_side_new_1106701", "1106701031", "story_v_side_new_1106701.awb")

						arg_127_1:RecordAudio("1106701031", var_130_9)
						arg_127_1:RecordAudio("1106701031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701031", "story_v_side_new_1106701.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701031", "story_v_side_new_1106701.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_3, arg_127_1.talkMaxDuration)

			if var_130_2 <= arg_127_1.time_ and arg_127_1.time_ < var_130_2 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_2) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_2 + var_130_10 and arg_127_1.time_ < var_130_2 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1106701032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1106701032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1106701033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1042ui_story"]) and arg_131_1.var_.characterEffect1042ui_story == nil then
				arg_131_1.var_.characterEffect1042ui_story = arg_131_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1042ui_story"]) then
				if arg_131_1.var_.characterEffect1042ui_story and not isNil(arg_131_1.actors_["1042ui_story"]) then
					arg_131_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1042ui_story"]) and arg_131_1.var_.characterEffect1042ui_story then
				arg_131_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_134_1 = 0
			local var_134_2 = 0.05

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(1106701032).content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 2 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 2)

				if (2 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 2)) > 0 and var_134_2 < var_134_5 then
					arg_131_1.talkMaxDuration = var_134_5

					if var_134_5 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + var_134_1
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_6 = math.max(var_134_2, arg_131_1.talkMaxDuration)

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_6 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_1) / var_134_6

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_1 + var_134_6 and arg_131_1.time_ < var_134_1 + var_134_6 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play1106701033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1106701033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1106701034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 1.225

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(1106701033).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 49 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 49)

				if (49 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 49)) > 0 and var_138_0 < var_138_3 then
					arg_135_1.talkMaxDuration = var_138_3

					if var_138_3 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_3 + 0
					end
				end

				arg_135_1.text_.text = var_138_1
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_4 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_4

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1106701034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1106701034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1106701035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.15

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(1106701034).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 6 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 6)

				if (6 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 6)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1106701035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1106701035
		arg_143_1.duration_ = 5.5

		local var_143_0 = {
			zh = 3.7,
			ja = 5.5
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1106701036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1042ui_story"]) and arg_143_1.var_.characterEffect1042ui_story == nil then
				arg_143_1.var_.characterEffect1042ui_story = arg_143_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1042ui_story"]) then
				if arg_143_1.var_.characterEffect1042ui_story and not isNil(arg_143_1.actors_["1042ui_story"]) then
					arg_143_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1042ui_story"]) and arg_143_1.var_.characterEffect1042ui_story then
				arg_143_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action428")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_146_2 = 0
			local var_146_3 = 0.525

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(1106701035)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 21 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 21)

				if (21 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 21)) > 0 and var_146_3 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701035", "story_v_side_new_1106701.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701035", "story_v_side_new_1106701.awb") / 1000

					if var_146_8 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_2
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_side_new_1106701", "1106701035", "story_v_side_new_1106701.awb")

						arg_143_1:RecordAudio("1106701035", var_146_9)
						arg_143_1:RecordAudio("1106701035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701035", "story_v_side_new_1106701.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701035", "story_v_side_new_1106701.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_10 and arg_143_1.time_ < var_146_2 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1106701036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1106701036
		arg_147_1.duration_ = 8

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1106701037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if arg_147_1.bgs_.ST25 == nil then
				local var_150_0 = Object.Instantiate(arg_147_1.paintGo_)

				var_150_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST25")
				var_150_0.name = "ST25"
				var_150_0.transform.parent = arg_147_1.stage_.transform
				var_150_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.bgs_.ST25 = var_150_0
			end

			if 1.5 < arg_147_1.time_ and arg_147_1.time_ <= 1.5 + arg_150_0 then
				local var_150_1 = arg_147_1.bgs_.ST25

				arg_147_1.bgs_.ST25.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_150_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_2 = var_150_1:GetComponent("SpriteRenderer")

				if var_150_2 and var_150_2.sprite then
					local var_150_3 = 2 * (var_150_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_150_1.transform.localScale = Vector3.New(var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "ST25" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_4 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_5 = 1.5

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_5 then
				local var_150_6 = Color.New(0, 0, 0)

				var_150_6.a = Mathf.Lerp(0, 1, (arg_147_1.time_ - var_150_4) / var_150_5)
				arg_147_1.mask_.color = var_150_6
			end

			if arg_147_1.time_ >= var_150_4 + var_150_5 and arg_147_1.time_ < var_150_4 + var_150_5 + arg_150_0 then
				local var_150_7 = Color.New(0, 0, 0)

				var_150_7.a = 1
				arg_147_1.mask_.color = var_150_7
			end

			local var_150_8 = 1.5

			if 1.5 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_9 = 1.5

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_9 then
				local var_150_10 = Color.New(0, 0, 0)

				var_150_10.a = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_8) / var_150_9)
				arg_147_1.mask_.color = var_150_10
			end

			if arg_147_1.time_ >= var_150_8 + var_150_9 and arg_147_1.time_ < var_150_8 + var_150_9 + arg_150_0 then
				local var_150_11 = Color.New(0, 0, 0)

				arg_147_1.mask_.enabled = false
				var_150_11.a = 0
				arg_147_1.mask_.color = var_150_11
			end

			local var_150_12 = arg_147_1.actors_["1042ui_story"].transform

			if 1.5 < arg_147_1.time_ and arg_147_1.time_ <= 1.5 + arg_150_0 then
				arg_147_1.var_.moveOldPos1042ui_story = var_150_12.localPosition
			end

			local var_150_13 = 0.001

			if 1.5 <= arg_147_1.time_ and arg_147_1.time_ < 1.5 + var_150_13 then
				var_150_12.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 1.5) / var_150_13)
				var_150_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_12.position).x, (manager.ui.mainCamera.transform.position - var_150_12.position).y, (manager.ui.mainCamera.transform.position - var_150_12.position).z)
				var_150_12.localEulerAngles.z = 0
				var_150_12.localEulerAngles.x = 0
				var_150_12.localEulerAngles = var_150_12.localEulerAngles
			end

			if arg_147_1.time_ >= 1.5 + var_150_13 and arg_147_1.time_ < 1.5 + var_150_13 + arg_150_0 then
				var_150_12.localPosition = Vector3.New(0, 100, 0)
				var_150_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_12.position).x, (manager.ui.mainCamera.transform.position - var_150_12.position).y, (manager.ui.mainCamera.transform.position - var_150_12.position).z)
				var_150_12.localEulerAngles.z = 0
				var_150_12.localEulerAngles.x = 0
				var_150_12.localEulerAngles = var_150_12.localEulerAngles
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_14 = 3
			local var_150_15 = 0.875

			if 3 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_16 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_16:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_17 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1106701036).content)

				arg_147_1.text_.text = var_150_17

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_19 = 35 <= 0 and var_150_15 or var_150_15 * (utf8.len(var_150_17) / 35)

				if (35 <= 0 and var_150_15 or var_150_15 * (utf8.len(var_150_17) / 35)) > 0 and var_150_15 < var_150_19 then
					arg_147_1.talkMaxDuration = var_150_19
					var_150_14 = var_150_14 + 0.3

					if var_150_19 + var_150_14 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_19 + var_150_14
					end
				end

				arg_147_1.text_.text = var_150_17
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_20 = var_150_14 + 0.3
			local var_150_21 = math.max(var_150_15, arg_147_1.talkMaxDuration)

			if var_150_14 + 0.3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_20 + var_150_21 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_20) / var_150_21

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_20 + var_150_21 and arg_147_1.time_ < var_150_20 + var_150_21 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play1106701037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1106701037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1106701038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1.425

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(1106701037).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 57 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 57)

				if (57 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 57)) > 0 and var_156_0 < var_156_3 then
					arg_153_1.talkMaxDuration = var_156_3

					if var_156_3 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_3 + 0
					end
				end

				arg_153_1.text_.text = var_156_1
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_4 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_4

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1106701038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1106701038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1106701039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 1.2

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(1106701038).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 48 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 48)

				if (48 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 48)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1106701039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1106701039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1106701040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.85

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(1106701039).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 74 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 74)

				if (74 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 74)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1106701040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1106701040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1106701041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.175

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(1106701040).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 7 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 7)

				if (7 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 7)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play1106701041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1106701041
		arg_169_1.duration_ = 6.5

		local var_169_0 = {
			zh = 6.5,
			ja = 6.466
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1106701042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if arg_169_1.actors_["1067ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1067ui_story"))) then
				local var_172_0 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_169_1.stage_.transform)

				var_172_0.name = "1067ui_story"
				var_172_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.actors_["1067ui_story"] = var_172_0

				local var_172_1 = var_172_0:GetComponentInChildren(typeof(CharacterEffect))

				var_172_1.enabled = true

				local var_172_2 = GameObjectTools.GetOrAddComponent(var_172_0, typeof(DynamicBoneHelper))

				if var_172_2 then
					var_172_2:EnableDynamicBone(false)
				end

				arg_169_1:ShowWeapon(var_172_1.transform, false)

				arg_169_1.var_["1067ui_story" .. "Animator"] = var_172_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_169_1.var_["1067ui_story" .. "Animator"].applyRootMotion = true
				arg_169_1.var_["1067ui_story" .. "LipSync"] = var_172_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_172_3 = arg_169_1.actors_["1067ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1067ui_story = var_172_3.localPosition
			end

			local var_172_4 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				var_172_3.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1067ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_169_1.time_ - 0) / var_172_4)
				var_172_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_3.position).x, (manager.ui.mainCamera.transform.position - var_172_3.position).y, (manager.ui.mainCamera.transform.position - var_172_3.position).z)
				var_172_3.localEulerAngles.z = 0
				var_172_3.localEulerAngles.x = 0
				var_172_3.localEulerAngles = var_172_3.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				var_172_3.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_172_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_3.position).x, (manager.ui.mainCamera.transform.position - var_172_3.position).y, (manager.ui.mainCamera.transform.position - var_172_3.position).z)
				var_172_3.localEulerAngles.z = 0
				var_172_3.localEulerAngles.x = 0
				var_172_3.localEulerAngles = var_172_3.localEulerAngles
			end

			local var_172_5 = arg_169_1.actors_["1067ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.characterEffect1067ui_story == nil then
				arg_169_1.var_.characterEffect1067ui_story = var_172_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_6 = 0.2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_6 and not isNil(var_172_5) then
				if arg_169_1.var_.characterEffect1067ui_story and not isNil(var_172_5) then
					arg_169_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_6 and arg_169_1.time_ < 0 + var_172_6 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.characterEffect1067ui_story then
				arg_169_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action7_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_172_8 = arg_169_1.actors_["1042ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1042ui_story = var_172_8.localPosition
			end

			local var_172_9 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_9 then
				var_172_8.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_169_1.time_ - 0) / var_172_9)
				var_172_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_8.position).x, (manager.ui.mainCamera.transform.position - var_172_8.position).y, (manager.ui.mainCamera.transform.position - var_172_8.position).z)
				var_172_8.localEulerAngles.z = 0
				var_172_8.localEulerAngles.x = 0
				var_172_8.localEulerAngles = var_172_8.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_9 and arg_169_1.time_ < 0 + var_172_9 + arg_172_0 then
				var_172_8.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_172_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_8.position).x, (manager.ui.mainCamera.transform.position - var_172_8.position).y, (manager.ui.mainCamera.transform.position - var_172_8.position).z)
				var_172_8.localEulerAngles.z = 0
				var_172_8.localEulerAngles.x = 0
				var_172_8.localEulerAngles = var_172_8.localEulerAngles
			end

			local var_172_10 = arg_169_1.actors_["1042ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_10) and arg_169_1.var_.characterEffect1042ui_story == nil then
				arg_169_1.var_.characterEffect1042ui_story = var_172_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.0166666666666667

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_11 and not isNil(var_172_10) then
				if arg_169_1.var_.characterEffect1042ui_story and not isNil(var_172_10) then
					arg_169_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_11)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_11 and arg_169_1.time_ < 0 + var_172_11 + arg_172_0 and not isNil(var_172_10) and arg_169_1.var_.characterEffect1042ui_story then
				arg_169_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_172_12 = 0
			local var_172_13 = 0.75

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_12 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_14 = arg_169_1:GetWordFromCfg(1106701041)
				local var_172_15 = arg_169_1:FormatText(var_172_14.content)

				arg_169_1.text_.text = var_172_15

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_17 = 30 <= 0 and var_172_13 or var_172_13 * (utf8.len(var_172_15) / 30)

				if (30 <= 0 and var_172_13 or var_172_13 * (utf8.len(var_172_15) / 30)) > 0 and var_172_13 < var_172_17 then
					arg_169_1.talkMaxDuration = var_172_17

					if var_172_17 + var_172_12 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_17 + var_172_12
					end
				end

				arg_169_1.text_.text = var_172_15
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701041", "story_v_side_new_1106701.awb") ~= 0 then
					local var_172_18 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701041", "story_v_side_new_1106701.awb") / 1000

					if var_172_18 + var_172_12 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_18 + var_172_12
					end

					if var_172_14.prefab_name ~= "" and arg_169_1.actors_[var_172_14.prefab_name] ~= nil then
						local var_172_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_14.prefab_name].transform, "story_v_side_new_1106701", "1106701041", "story_v_side_new_1106701.awb")

						arg_169_1:RecordAudio("1106701041", var_172_19)
						arg_169_1:RecordAudio("1106701041", var_172_19)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701041", "story_v_side_new_1106701.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701041", "story_v_side_new_1106701.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_20 = math.max(var_172_13, arg_169_1.talkMaxDuration)

			if var_172_12 <= arg_169_1.time_ and arg_169_1.time_ < var_172_12 + var_172_20 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_12) / var_172_20

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_12 + var_172_20 and arg_169_1.time_ < var_172_12 + var_172_20 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play1106701042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1106701042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1106701043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1067ui_story"]) and arg_173_1.var_.characterEffect1067ui_story == nil then
				arg_173_1.var_.characterEffect1067ui_story = arg_173_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1067ui_story"]) then
				if arg_173_1.var_.characterEffect1067ui_story and not isNil(arg_173_1.actors_["1067ui_story"]) then
					arg_173_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1067ui_story"]) and arg_173_1.var_.characterEffect1067ui_story then
				arg_173_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_176_1 = 0
			local var_176_2 = 0.5

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(1106701042).content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 20 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 20)

				if (20 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 20)) > 0 and var_176_2 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_1 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_1
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_6 = math.max(var_176_2, arg_173_1.talkMaxDuration)

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_6 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_1) / var_176_6

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_1 + var_176_6 and arg_173_1.time_ < var_176_1 + var_176_6 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1106701043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1106701043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1106701044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.7

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(1106701043).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 28 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 28)

				if (28 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 28)) > 0 and var_180_0 < var_180_3 then
					arg_177_1.talkMaxDuration = var_180_3

					if var_180_3 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_3 + 0
					end
				end

				arg_177_1.text_.text = var_180_1
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_4 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_4

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1106701044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1106701044
		arg_181_1.duration_ = 9.9

		local var_181_0 = {
			zh = 9.9,
			ja = 7.933
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1106701045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1042ui_story = arg_181_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1042ui_story"].transform.position).z)
				arg_181_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1042ui_story"].transform.localEulerAngles = arg_181_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_181_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1042ui_story"].transform.position).z)
				arg_181_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1042ui_story"].transform.localEulerAngles = arg_181_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1067ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1067ui_story = var_184_1.localPosition
			end

			local var_184_2 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 then
				var_184_1.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1067ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_181_1.time_ - 0) / var_184_2)
				var_184_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_1.position).x, (manager.ui.mainCamera.transform.position - var_184_1.position).y, (manager.ui.mainCamera.transform.position - var_184_1.position).z)
				var_184_1.localEulerAngles.z = 0
				var_184_1.localEulerAngles.x = 0
				var_184_1.localEulerAngles = var_184_1.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 then
				var_184_1.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_184_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_1.position).x, (manager.ui.mainCamera.transform.position - var_184_1.position).y, (manager.ui.mainCamera.transform.position - var_184_1.position).z)
				var_184_1.localEulerAngles.z = 0
				var_184_1.localEulerAngles.x = 0
				var_184_1.localEulerAngles = var_184_1.localEulerAngles
			end

			local var_184_3 = arg_181_1.actors_["1042ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_3) and arg_181_1.var_.characterEffect1042ui_story == nil then
				arg_181_1.var_.characterEffect1042ui_story = var_184_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_4 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 and not isNil(var_184_3) then
				if arg_181_1.var_.characterEffect1042ui_story and not isNil(var_184_3) then
					arg_181_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 and not isNil(var_184_3) and arg_181_1.var_.characterEffect1042ui_story then
				arg_181_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action5_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_184_6 = 0
			local var_184_7 = 1.2

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:GetWordFromCfg(1106701044)
				local var_184_9 = arg_181_1:FormatText(var_184_8.content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 48 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 48)

				if (48 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 48)) > 0 and var_184_7 < var_184_11 then
					arg_181_1.talkMaxDuration = var_184_11

					if var_184_11 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701044", "story_v_side_new_1106701.awb") ~= 0 then
					local var_184_12 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701044", "story_v_side_new_1106701.awb") / 1000

					if var_184_12 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_6
					end

					if var_184_8.prefab_name ~= "" and arg_181_1.actors_[var_184_8.prefab_name] ~= nil then
						local var_184_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_8.prefab_name].transform, "story_v_side_new_1106701", "1106701044", "story_v_side_new_1106701.awb")

						arg_181_1:RecordAudio("1106701044", var_184_13)
						arg_181_1:RecordAudio("1106701044", var_184_13)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701044", "story_v_side_new_1106701.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701044", "story_v_side_new_1106701.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play1106701045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1106701045
		arg_185_1.duration_ = 7.53

		local var_185_0 = {
			zh = 4.4,
			ja = 7.533
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1106701046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1067ui_story"]) and arg_185_1.var_.characterEffect1067ui_story == nil then
				arg_185_1.var_.characterEffect1067ui_story = arg_185_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1067ui_story"]) then
				if arg_185_1.var_.characterEffect1067ui_story and not isNil(arg_185_1.actors_["1067ui_story"]) then
					arg_185_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1067ui_story"]) and arg_185_1.var_.characterEffect1067ui_story then
				arg_185_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_188_2 = arg_185_1.actors_["1042ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.characterEffect1042ui_story == nil then
				arg_185_1.var_.characterEffect1042ui_story = var_188_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_3 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.characterEffect1042ui_story and not isNil(var_188_2) then
					arg_185_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_3)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.characterEffect1042ui_story then
				arg_185_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_188_4 = 0
			local var_188_5 = 0.5

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(1106701045)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 20 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 20)

				if (20 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 20)) > 0 and var_188_5 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701045", "story_v_side_new_1106701.awb") ~= 0 then
					local var_188_10 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701045", "story_v_side_new_1106701.awb") / 1000

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end

					if var_188_6.prefab_name ~= "" and arg_185_1.actors_[var_188_6.prefab_name] ~= nil then
						local var_188_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_6.prefab_name].transform, "story_v_side_new_1106701", "1106701045", "story_v_side_new_1106701.awb")

						arg_185_1:RecordAudio("1106701045", var_188_11)
						arg_185_1:RecordAudio("1106701045", var_188_11)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701045", "story_v_side_new_1106701.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701045", "story_v_side_new_1106701.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_12 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_12 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_12

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_12 and arg_185_1.time_ < var_188_4 + var_188_12 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1106701046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1106701046
		arg_189_1.duration_ = 4.83

		local var_189_0 = {
			zh = 4.833,
			ja = 4.7
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1106701047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1067ui_story"]) and arg_189_1.var_.characterEffect1067ui_story == nil then
				arg_189_1.var_.characterEffect1067ui_story = arg_189_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1067ui_story"]) then
				if arg_189_1.var_.characterEffect1067ui_story and not isNil(arg_189_1.actors_["1067ui_story"]) then
					arg_189_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1067ui_story"]) and arg_189_1.var_.characterEffect1067ui_story then
				arg_189_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_192_1 = arg_189_1.actors_["1042ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1042ui_story == nil then
				arg_189_1.var_.characterEffect1042ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1042ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1042ui_story then
				arg_189_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action456")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_192_4 = 0
			local var_192_5 = 0.4

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(1106701046)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 16 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 16)

				if (16 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 16)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701046", "story_v_side_new_1106701.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701046", "story_v_side_new_1106701.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_side_new_1106701", "1106701046", "story_v_side_new_1106701.awb")

						arg_189_1:RecordAudio("1106701046", var_192_11)
						arg_189_1:RecordAudio("1106701046", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701046", "story_v_side_new_1106701.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701046", "story_v_side_new_1106701.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_12 and arg_189_1.time_ < var_192_4 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1106701047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1106701047
		arg_193_1.duration_ = 8.57

		local var_193_0 = {
			zh = 5.4,
			ja = 8.566
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1106701048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action6_2")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_196_0 = 0
			local var_196_1 = 0.625

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(1106701047)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 25 <= 0 and var_196_1 or var_196_1 * (utf8.len(var_196_3) / 25)

				if (25 <= 0 and var_196_1 or var_196_1 * (utf8.len(var_196_3) / 25)) > 0 and var_196_1 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701047", "story_v_side_new_1106701.awb") ~= 0 then
					local var_196_6 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701047", "story_v_side_new_1106701.awb") / 1000

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end

					if var_196_2.prefab_name ~= "" and arg_193_1.actors_[var_196_2.prefab_name] ~= nil then
						local var_196_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_2.prefab_name].transform, "story_v_side_new_1106701", "1106701047", "story_v_side_new_1106701.awb")

						arg_193_1:RecordAudio("1106701047", var_196_7)
						arg_193_1:RecordAudio("1106701047", var_196_7)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701047", "story_v_side_new_1106701.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701047", "story_v_side_new_1106701.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_8 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_8 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_8

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_8 and arg_193_1.time_ < var_196_0 + var_196_8 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1106701048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1106701048
		arg_197_1.duration_ = 2.27

		local var_197_0 = {
			zh = 2.2,
			ja = 2.266
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1106701049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1067ui_story"]) and arg_197_1.var_.characterEffect1067ui_story == nil then
				arg_197_1.var_.characterEffect1067ui_story = arg_197_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1067ui_story"]) then
				if arg_197_1.var_.characterEffect1067ui_story and not isNil(arg_197_1.actors_["1067ui_story"]) then
					arg_197_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1067ui_story"]) and arg_197_1.var_.characterEffect1067ui_story then
				arg_197_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_200_2 = arg_197_1.actors_["1042ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.characterEffect1042ui_story == nil then
				arg_197_1.var_.characterEffect1042ui_story = var_200_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_3 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.characterEffect1042ui_story and not isNil(var_200_2) then
					arg_197_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_3)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.characterEffect1042ui_story then
				arg_197_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action473")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_200_4 = 0
			local var_200_5 = 0.25

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(1106701048)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 10 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 10)

				if (10 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 10)) > 0 and var_200_5 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701048", "story_v_side_new_1106701.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701048", "story_v_side_new_1106701.awb") / 1000

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end

					if var_200_6.prefab_name ~= "" and arg_197_1.actors_[var_200_6.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_6.prefab_name].transform, "story_v_side_new_1106701", "1106701048", "story_v_side_new_1106701.awb")

						arg_197_1:RecordAudio("1106701048", var_200_11)
						arg_197_1:RecordAudio("1106701048", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701048", "story_v_side_new_1106701.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701048", "story_v_side_new_1106701.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_12 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_12 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_12

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_12 and arg_197_1.time_ < var_200_4 + var_200_12 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1106701049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1106701049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1106701050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1042ui_story = arg_201_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1042ui_story"].transform.position).z)
				arg_201_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1042ui_story"].transform.localEulerAngles = arg_201_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1042ui_story"].transform.position).z)
				arg_201_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1042ui_story"].transform.localEulerAngles = arg_201_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1067ui_story"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1067ui_story = var_204_1.localPosition
			end

			local var_204_2 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 then
				var_204_1.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_2)
				var_204_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_1.position).x, (manager.ui.mainCamera.transform.position - var_204_1.position).y, (manager.ui.mainCamera.transform.position - var_204_1.position).z)
				var_204_1.localEulerAngles.z = 0
				var_204_1.localEulerAngles.x = 0
				var_204_1.localEulerAngles = var_204_1.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 then
				var_204_1.localPosition = Vector3.New(0, 100, 0)
				var_204_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_1.position).x, (manager.ui.mainCamera.transform.position - var_204_1.position).y, (manager.ui.mainCamera.transform.position - var_204_1.position).z)
				var_204_1.localEulerAngles.z = 0
				var_204_1.localEulerAngles.x = 0
				var_204_1.localEulerAngles = var_204_1.localEulerAngles
			end

			local var_204_3 = 0
			local var_204_4 = 0.8

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_3 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_5 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(1106701049).content)

				arg_201_1.text_.text = var_204_5

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 32 <= 0 and var_204_4 or var_204_4 * (utf8.len(var_204_5) / 32)

				if (32 <= 0 and var_204_4 or var_204_4 * (utf8.len(var_204_5) / 32)) > 0 and var_204_4 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_3 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_3
					end
				end

				arg_201_1.text_.text = var_204_5
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_4, arg_201_1.talkMaxDuration)

			if var_204_3 <= arg_201_1.time_ and arg_201_1.time_ < var_204_3 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_3) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_3 + var_204_8 and arg_201_1.time_ < var_204_3 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play1106701050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1106701050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1106701051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1.05

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(1106701050).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 42 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 42)

				if (42 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 42)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1106701051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1106701051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1106701052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.425

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(1106701051).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 17 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 17)

				if (17 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 17)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1106701052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1106701052
		arg_213_1.duration_ = 9.5

		local var_213_0 = {
			zh = 5.866,
			ja = 9.5
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1106701053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1042ui_story = arg_213_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1042ui_story"].transform.position).z)
				arg_213_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1042ui_story"].transform.localEulerAngles = arg_213_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_213_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1042ui_story"].transform.position).z)
				arg_213_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1042ui_story"].transform.localEulerAngles = arg_213_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1042ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1042ui_story == nil then
				arg_213_1.var_.characterEffect1042ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1042ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1042ui_story then
				arg_213_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_216_4 = arg_213_1.actors_["1067ui_story"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1067ui_story = var_216_4.localPosition
			end

			local var_216_5 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_5 then
				var_216_4.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1067ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_213_1.time_ - 0) / var_216_5)
				var_216_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_4.position).x, (manager.ui.mainCamera.transform.position - var_216_4.position).y, (manager.ui.mainCamera.transform.position - var_216_4.position).z)
				var_216_4.localEulerAngles.z = 0
				var_216_4.localEulerAngles.x = 0
				var_216_4.localEulerAngles = var_216_4.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_5 and arg_213_1.time_ < 0 + var_216_5 + arg_216_0 then
				var_216_4.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_216_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_4.position).x, (manager.ui.mainCamera.transform.position - var_216_4.position).y, (manager.ui.mainCamera.transform.position - var_216_4.position).z)
				var_216_4.localEulerAngles.z = 0
				var_216_4.localEulerAngles.x = 0
				var_216_4.localEulerAngles = var_216_4.localEulerAngles
			end

			local var_216_6 = arg_213_1.actors_["1067ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1067ui_story == nil then
				arg_213_1.var_.characterEffect1067ui_story = var_216_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_7 = 0.0166666666666667

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 and not isNil(var_216_6) then
				if arg_213_1.var_.characterEffect1067ui_story and not isNil(var_216_6) then
					arg_213_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_7)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1067ui_story then
				arg_213_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_216_8 = 0
			local var_216_9 = 0.65

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_10 = arg_213_1:GetWordFromCfg(1106701052)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.text_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_13 = 26 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 26)

				if (26 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 26)) > 0 and var_216_9 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_11
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701052", "story_v_side_new_1106701.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701052", "story_v_side_new_1106701.awb") / 1000

					if var_216_14 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_8
					end

					if var_216_10.prefab_name ~= "" and arg_213_1.actors_[var_216_10.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_10.prefab_name].transform, "story_v_side_new_1106701", "1106701052", "story_v_side_new_1106701.awb")

						arg_213_1:RecordAudio("1106701052", var_216_15)
						arg_213_1:RecordAudio("1106701052", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701052", "story_v_side_new_1106701.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701052", "story_v_side_new_1106701.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_16 = math.max(var_216_9, arg_213_1.talkMaxDuration)

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_16 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_8) / var_216_16

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_8 + var_216_16 and arg_213_1.time_ < var_216_8 + var_216_16 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play1106701053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1106701053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1106701054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1042ui_story"]) and arg_217_1.var_.characterEffect1042ui_story == nil then
				arg_217_1.var_.characterEffect1042ui_story = arg_217_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1042ui_story"]) then
				if arg_217_1.var_.characterEffect1042ui_story and not isNil(arg_217_1.actors_["1042ui_story"]) then
					arg_217_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1042ui_story"]) and arg_217_1.var_.characterEffect1042ui_story then
				arg_217_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_220_1 = 0
			local var_220_2 = 0.3

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(1106701053).content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 12 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 12)

				if (12 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 12)) > 0 and var_220_2 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_6 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_6 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_6

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_6 and arg_217_1.time_ < var_220_1 + var_220_6 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1106701054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1106701054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1106701055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_224_0 = 0
			local var_224_1 = 0.8

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_2 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(1106701054).content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 32 <= 0 and var_224_1 or var_224_1 * (utf8.len(var_224_2) / 32)

				if (32 <= 0 and var_224_1 or var_224_1 * (utf8.len(var_224_2) / 32)) > 0 and var_224_1 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_5 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_5 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_5

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_5 and arg_221_1.time_ < var_224_0 + var_224_5 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1106701055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1106701055
		arg_225_1.duration_ = 3.77

		local var_225_0 = {
			zh = 3.166,
			ja = 3.766
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1106701056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1042ui_story = arg_225_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1042ui_story"].transform.position).z)
				arg_225_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1042ui_story"].transform.localEulerAngles = arg_225_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_225_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1042ui_story"].transform.position).z)
				arg_225_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1042ui_story"].transform.localEulerAngles = arg_225_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["1067ui_story"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1067ui_story = var_228_1.localPosition
			end

			local var_228_2 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 then
				var_228_1.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1067ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_225_1.time_ - 0) / var_228_2)
				var_228_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_1.position).x, (manager.ui.mainCamera.transform.position - var_228_1.position).y, (manager.ui.mainCamera.transform.position - var_228_1.position).z)
				var_228_1.localEulerAngles.z = 0
				var_228_1.localEulerAngles.x = 0
				var_228_1.localEulerAngles = var_228_1.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 then
				var_228_1.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_228_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_1.position).x, (manager.ui.mainCamera.transform.position - var_228_1.position).y, (manager.ui.mainCamera.transform.position - var_228_1.position).z)
				var_228_1.localEulerAngles.z = 0
				var_228_1.localEulerAngles.x = 0
				var_228_1.localEulerAngles = var_228_1.localEulerAngles
			end

			local var_228_3 = arg_225_1.actors_["1067ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_3) and arg_225_1.var_.characterEffect1067ui_story == nil then
				arg_225_1.var_.characterEffect1067ui_story = var_228_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_4 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 and not isNil(var_228_3) then
				if arg_225_1.var_.characterEffect1067ui_story and not isNil(var_228_3) then
					arg_225_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 and not isNil(var_228_3) and arg_225_1.var_.characterEffect1067ui_story then
				arg_225_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action437")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_228_6 = 0
			local var_228_7 = 0.35

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_8 = arg_225_1:GetWordFromCfg(1106701055)
				local var_228_9 = arg_225_1:FormatText(var_228_8.content)

				arg_225_1.text_.text = var_228_9

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 14 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_9) / 14)

				if (14 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_9) / 14)) > 0 and var_228_7 < var_228_11 then
					arg_225_1.talkMaxDuration = var_228_11

					if var_228_11 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_9
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701055", "story_v_side_new_1106701.awb") ~= 0 then
					local var_228_12 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701055", "story_v_side_new_1106701.awb") / 1000

					if var_228_12 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_12 + var_228_6
					end

					if var_228_8.prefab_name ~= "" and arg_225_1.actors_[var_228_8.prefab_name] ~= nil then
						local var_228_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_8.prefab_name].transform, "story_v_side_new_1106701", "1106701055", "story_v_side_new_1106701.awb")

						arg_225_1:RecordAudio("1106701055", var_228_13)
						arg_225_1:RecordAudio("1106701055", var_228_13)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701055", "story_v_side_new_1106701.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701055", "story_v_side_new_1106701.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play1106701056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1106701056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1106701057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1067ui_story"]) and arg_229_1.var_.characterEffect1067ui_story == nil then
				arg_229_1.var_.characterEffect1067ui_story = arg_229_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1067ui_story"]) then
				if arg_229_1.var_.characterEffect1067ui_story and not isNil(arg_229_1.actors_["1067ui_story"]) then
					arg_229_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1067ui_story"]) and arg_229_1.var_.characterEffect1067ui_story then
				arg_229_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_232_1 = 0
			local var_232_2 = 0.05

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(1106701056).content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 2 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 2)

				if (2 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 2)) > 0 and var_232_2 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_6 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_6 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_6

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_6 and arg_229_1.time_ < var_232_1 + var_232_6 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1106701057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1106701057
		arg_233_1.duration_ = 4.47

		local var_233_0 = {
			zh = 2.9,
			ja = 4.466
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1106701058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1067ui_story"]) and arg_233_1.var_.characterEffect1067ui_story == nil then
				arg_233_1.var_.characterEffect1067ui_story = arg_233_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1067ui_story"]) then
				if arg_233_1.var_.characterEffect1067ui_story and not isNil(arg_233_1.actors_["1067ui_story"]) then
					arg_233_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1067ui_story"]) and arg_233_1.var_.characterEffect1067ui_story then
				arg_233_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_236_2 = 0
			local var_236_3 = 0.3

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_4 = arg_233_1:GetWordFromCfg(1106701057)
				local var_236_5 = arg_233_1:FormatText(var_236_4.content)

				arg_233_1.text_.text = var_236_5

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_7 = 12 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 12)

				if (12 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 12)) > 0 and var_236_3 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_2
					end
				end

				arg_233_1.text_.text = var_236_5
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701057", "story_v_side_new_1106701.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701057", "story_v_side_new_1106701.awb") / 1000

					if var_236_8 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_2
					end

					if var_236_4.prefab_name ~= "" and arg_233_1.actors_[var_236_4.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_4.prefab_name].transform, "story_v_side_new_1106701", "1106701057", "story_v_side_new_1106701.awb")

						arg_233_1:RecordAudio("1106701057", var_236_9)
						arg_233_1:RecordAudio("1106701057", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701057", "story_v_side_new_1106701.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701057", "story_v_side_new_1106701.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_3, arg_233_1.talkMaxDuration)

			if var_236_2 <= arg_233_1.time_ and arg_233_1.time_ < var_236_2 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_2) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_2 + var_236_10 and arg_233_1.time_ < var_236_2 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1106701058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1106701058
		arg_237_1.duration_ = 6.3

		local var_237_0 = {
			zh = 2.133,
			ja = 6.3
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1106701059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1067ui_story"]) and arg_237_1.var_.characterEffect1067ui_story == nil then
				arg_237_1.var_.characterEffect1067ui_story = arg_237_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1067ui_story"]) then
				if arg_237_1.var_.characterEffect1067ui_story and not isNil(arg_237_1.actors_["1067ui_story"]) then
					arg_237_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1067ui_story"]) and arg_237_1.var_.characterEffect1067ui_story then
				arg_237_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_240_1 = arg_237_1.actors_["1042ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1042ui_story == nil then
				arg_237_1.var_.characterEffect1042ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1042ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1042ui_story then
				arg_237_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_240_4 = 0
			local var_240_5 = 0.225

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:GetWordFromCfg(1106701058)
				local var_240_7 = arg_237_1:FormatText(var_240_6.content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 9 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 9)

				if (9 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 9)) > 0 and var_240_5 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701058", "story_v_side_new_1106701.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701058", "story_v_side_new_1106701.awb") / 1000

					if var_240_10 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_4
					end

					if var_240_6.prefab_name ~= "" and arg_237_1.actors_[var_240_6.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_6.prefab_name].transform, "story_v_side_new_1106701", "1106701058", "story_v_side_new_1106701.awb")

						arg_237_1:RecordAudio("1106701058", var_240_11)
						arg_237_1:RecordAudio("1106701058", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701058", "story_v_side_new_1106701.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701058", "story_v_side_new_1106701.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_12 and arg_237_1.time_ < var_240_4 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1106701059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1106701059
		arg_241_1.duration_ = 4.73

		local var_241_0 = {
			zh = 2.5,
			ja = 4.733
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1106701060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_244_0 = 0
			local var_244_1 = 0.3

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_2 = arg_241_1:GetWordFromCfg(1106701059)
				local var_244_3 = arg_241_1:FormatText(var_244_2.content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 12 <= 0 and var_244_1 or var_244_1 * (utf8.len(var_244_3) / 12)

				if (12 <= 0 and var_244_1 or var_244_1 * (utf8.len(var_244_3) / 12)) > 0 and var_244_1 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701059", "story_v_side_new_1106701.awb") ~= 0 then
					local var_244_6 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701059", "story_v_side_new_1106701.awb") / 1000

					if var_244_6 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_0
					end

					if var_244_2.prefab_name ~= "" and arg_241_1.actors_[var_244_2.prefab_name] ~= nil then
						local var_244_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_2.prefab_name].transform, "story_v_side_new_1106701", "1106701059", "story_v_side_new_1106701.awb")

						arg_241_1:RecordAudio("1106701059", var_244_7)
						arg_241_1:RecordAudio("1106701059", var_244_7)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701059", "story_v_side_new_1106701.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701059", "story_v_side_new_1106701.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_8 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_8 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_8

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_8 and arg_241_1.time_ < var_244_0 + var_244_8 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1106701060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1106701060
		arg_245_1.duration_ = 8

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1106701061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.mask_.enabled = true
				arg_245_1.mask_.raycastTarget = false

				arg_245_1:SetGaussion(false)
			end

			local var_248_0 = 1.5

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				local var_248_1 = Color.New(0, 0, 0)

				var_248_1.a = Mathf.Lerp(0, 1, (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.mask_.color = var_248_1
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				local var_248_2 = Color.New(0, 0, 0)

				var_248_2.a = 1
				arg_245_1.mask_.color = var_248_2
			end

			local var_248_3 = 1.5

			if 1.5 < arg_245_1.time_ and arg_245_1.time_ <= var_248_3 + arg_248_0 then
				arg_245_1.mask_.enabled = true
				arg_245_1.mask_.raycastTarget = false

				arg_245_1:SetGaussion(false)
			end

			local var_248_4 = 1.5

			if var_248_3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_3 + var_248_4 then
				local var_248_5 = Color.New(0, 0, 0)

				var_248_5.a = Mathf.Lerp(1, 0, (arg_245_1.time_ - var_248_3) / var_248_4)
				arg_245_1.mask_.color = var_248_5
			end

			if arg_245_1.time_ >= var_248_3 + var_248_4 and arg_245_1.time_ < var_248_3 + var_248_4 + arg_248_0 then
				local var_248_6 = Color.New(0, 0, 0)

				arg_245_1.mask_.enabled = false
				var_248_6.a = 0
				arg_245_1.mask_.color = var_248_6
			end

			local var_248_7 = arg_245_1.actors_["1042ui_story"].transform

			if 1.5 < arg_245_1.time_ and arg_245_1.time_ <= 1.5 + arg_248_0 then
				arg_245_1.var_.moveOldPos1042ui_story = var_248_7.localPosition
			end

			local var_248_8 = 0.001

			if 1.5 <= arg_245_1.time_ and arg_245_1.time_ < 1.5 + var_248_8 then
				var_248_7.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 1.5) / var_248_8)
				var_248_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_7.position).x, (manager.ui.mainCamera.transform.position - var_248_7.position).y, (manager.ui.mainCamera.transform.position - var_248_7.position).z)
				var_248_7.localEulerAngles.z = 0
				var_248_7.localEulerAngles.x = 0
				var_248_7.localEulerAngles = var_248_7.localEulerAngles
			end

			if arg_245_1.time_ >= 1.5 + var_248_8 and arg_245_1.time_ < 1.5 + var_248_8 + arg_248_0 then
				var_248_7.localPosition = Vector3.New(0, 100, 0)
				var_248_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_7.position).x, (manager.ui.mainCamera.transform.position - var_248_7.position).y, (manager.ui.mainCamera.transform.position - var_248_7.position).z)
				var_248_7.localEulerAngles.z = 0
				var_248_7.localEulerAngles.x = 0
				var_248_7.localEulerAngles = var_248_7.localEulerAngles
			end

			local var_248_9 = arg_245_1.actors_["1067ui_story"].transform

			if 1.5 < arg_245_1.time_ and arg_245_1.time_ <= 1.5 + arg_248_0 then
				arg_245_1.var_.moveOldPos1067ui_story = var_248_9.localPosition
			end

			local var_248_10 = 0.001

			if 1.5 <= arg_245_1.time_ and arg_245_1.time_ < 1.5 + var_248_10 then
				var_248_9.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 1.5) / var_248_10)
				var_248_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_9.position).x, (manager.ui.mainCamera.transform.position - var_248_9.position).y, (manager.ui.mainCamera.transform.position - var_248_9.position).z)
				var_248_9.localEulerAngles.z = 0
				var_248_9.localEulerAngles.x = 0
				var_248_9.localEulerAngles = var_248_9.localEulerAngles
			end

			if arg_245_1.time_ >= 1.5 + var_248_10 and arg_245_1.time_ < 1.5 + var_248_10 + arg_248_0 then
				var_248_9.localPosition = Vector3.New(0, 100, 0)
				var_248_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_9.position).x, (manager.ui.mainCamera.transform.position - var_248_9.position).y, (manager.ui.mainCamera.transform.position - var_248_9.position).z)
				var_248_9.localEulerAngles.z = 0
				var_248_9.localEulerAngles.x = 0
				var_248_9.localEulerAngles = var_248_9.localEulerAngles
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_11 = 3
			local var_248_12 = 0.55

			if 3 < arg_245_1.time_ and arg_245_1.time_ <= var_248_11 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_13 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_13:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_14 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(1106701060).content)

				arg_245_1.text_.text = var_248_14

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_16 = 22 <= 0 and var_248_12 or var_248_12 * (utf8.len(var_248_14) / 22)

				if (22 <= 0 and var_248_12 or var_248_12 * (utf8.len(var_248_14) / 22)) > 0 and var_248_12 < var_248_16 then
					arg_245_1.talkMaxDuration = var_248_16
					var_248_11 = var_248_11 + 0.3

					if var_248_16 + var_248_11 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_16 + var_248_11
					end
				end

				arg_245_1.text_.text = var_248_14
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_17 = var_248_11 + 0.3
			local var_248_18 = math.max(var_248_12, arg_245_1.talkMaxDuration)

			if var_248_11 + 0.3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_17 + var_248_18 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_17) / var_248_18

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_17 + var_248_18 and arg_245_1.time_ < var_248_17 + var_248_18 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play1106701061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1106701061
		arg_251_1.duration_ = 8.8

		local var_251_0 = {
			zh = 8.8,
			ja = 8.3
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1106701062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1042ui_story = arg_251_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1042ui_story"].transform.position).z)
				arg_251_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1042ui_story"].transform.localEulerAngles = arg_251_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_251_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1042ui_story"].transform.position).z)
				arg_251_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1042ui_story"].transform.localEulerAngles = arg_251_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["1042ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1042ui_story == nil then
				arg_251_1.var_.characterEffect1042ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect1042ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1042ui_story then
				arg_251_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_254_4 = 0
			local var_254_5 = 1.075

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_4 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_6 = arg_251_1:GetWordFromCfg(1106701061)
				local var_254_7 = arg_251_1:FormatText(var_254_6.content)

				arg_251_1.text_.text = var_254_7

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_9 = 43 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 43)

				if (43 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 43)) > 0 and var_254_5 < var_254_9 then
					arg_251_1.talkMaxDuration = var_254_9

					if var_254_9 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_9 + var_254_4
					end
				end

				arg_251_1.text_.text = var_254_7
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701061", "story_v_side_new_1106701.awb") ~= 0 then
					local var_254_10 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701061", "story_v_side_new_1106701.awb") / 1000

					if var_254_10 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_4
					end

					if var_254_6.prefab_name ~= "" and arg_251_1.actors_[var_254_6.prefab_name] ~= nil then
						local var_254_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_6.prefab_name].transform, "story_v_side_new_1106701", "1106701061", "story_v_side_new_1106701.awb")

						arg_251_1:RecordAudio("1106701061", var_254_11)
						arg_251_1:RecordAudio("1106701061", var_254_11)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701061", "story_v_side_new_1106701.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701061", "story_v_side_new_1106701.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_12 = math.max(var_254_5, arg_251_1.talkMaxDuration)

			if var_254_4 <= arg_251_1.time_ and arg_251_1.time_ < var_254_4 + var_254_12 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_4) / var_254_12

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_4 + var_254_12 and arg_251_1.time_ < var_254_4 + var_254_12 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play1106701062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1106701062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1106701063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1042ui_story"]) and arg_255_1.var_.characterEffect1042ui_story == nil then
				arg_255_1.var_.characterEffect1042ui_story = arg_255_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1042ui_story"]) then
				if arg_255_1.var_.characterEffect1042ui_story and not isNil(arg_255_1.actors_["1042ui_story"]) then
					arg_255_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1042ui_story"]) and arg_255_1.var_.characterEffect1042ui_story then
				arg_255_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_258_1 = 0
			local var_258_2 = 0.4

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(1106701062).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 16 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 16)

				if (16 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 16)) > 0 and var_258_2 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_6 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_6 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_1) / var_258_6

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_1 + var_258_6 and arg_255_1.time_ < var_258_1 + var_258_6 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1106701063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1106701063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1106701064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.85

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(1106701063).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 34 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 34)

				if (34 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 34)) > 0 and var_262_0 < var_262_3 then
					arg_259_1.talkMaxDuration = var_262_3

					if var_262_3 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_3 + 0
					end
				end

				arg_259_1.text_.text = var_262_1
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_4 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_4

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1106701064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1106701064
		arg_263_1.duration_ = 3.5

		local var_263_0 = {
			zh = 3.5,
			ja = 2.6
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1106701065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1042ui_story"]) and arg_263_1.var_.characterEffect1042ui_story == nil then
				arg_263_1.var_.characterEffect1042ui_story = arg_263_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1042ui_story"]) then
				if arg_263_1.var_.characterEffect1042ui_story and not isNil(arg_263_1.actors_["1042ui_story"]) then
					arg_263_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1042ui_story"]) and arg_263_1.var_.characterEffect1042ui_story then
				arg_263_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action424")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_266_2 = 0
			local var_266_3 = 0.375

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_2 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_4 = arg_263_1:GetWordFromCfg(1106701064)
				local var_266_5 = arg_263_1:FormatText(var_266_4.content)

				arg_263_1.text_.text = var_266_5

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_7 = 15 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_5) / 15)

				if (15 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_5) / 15)) > 0 and var_266_3 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_2
					end
				end

				arg_263_1.text_.text = var_266_5
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701064", "story_v_side_new_1106701.awb") ~= 0 then
					local var_266_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701064", "story_v_side_new_1106701.awb") / 1000

					if var_266_8 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_2
					end

					if var_266_4.prefab_name ~= "" and arg_263_1.actors_[var_266_4.prefab_name] ~= nil then
						local var_266_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_4.prefab_name].transform, "story_v_side_new_1106701", "1106701064", "story_v_side_new_1106701.awb")

						arg_263_1:RecordAudio("1106701064", var_266_9)
						arg_263_1:RecordAudio("1106701064", var_266_9)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701064", "story_v_side_new_1106701.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701064", "story_v_side_new_1106701.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_10 = math.max(var_266_3, arg_263_1.talkMaxDuration)

			if var_266_2 <= arg_263_1.time_ and arg_263_1.time_ < var_266_2 + var_266_10 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_2) / var_266_10

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_2 + var_266_10 and arg_263_1.time_ < var_266_2 + var_266_10 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play1106701065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1106701065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1106701066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1042ui_story"]) and arg_267_1.var_.characterEffect1042ui_story == nil then
				arg_267_1.var_.characterEffect1042ui_story = arg_267_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1042ui_story"]) then
				if arg_267_1.var_.characterEffect1042ui_story and not isNil(arg_267_1.actors_["1042ui_story"]) then
					arg_267_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_0)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1042ui_story"]) and arg_267_1.var_.characterEffect1042ui_story then
				arg_267_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_270_1 = 0
			local var_270_2 = 0.125

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_3 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(1106701065).content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 5 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 5)

				if (5 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 5)) > 0 and var_270_2 < var_270_5 then
					arg_267_1.talkMaxDuration = var_270_5

					if var_270_5 + var_270_1 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + var_270_1
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_6 = math.max(var_270_2, arg_267_1.talkMaxDuration)

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_6 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_1) / var_270_6

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_1 + var_270_6 and arg_267_1.time_ < var_270_1 + var_270_6 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1106701066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1106701066
		arg_271_1.duration_ = 17.4

		local var_271_0 = {
			zh = 12.433,
			ja = 17.4
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1106701067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1042ui_story"]) and arg_271_1.var_.characterEffect1042ui_story == nil then
				arg_271_1.var_.characterEffect1042ui_story = arg_271_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1042ui_story"]) then
				if arg_271_1.var_.characterEffect1042ui_story and not isNil(arg_271_1.actors_["1042ui_story"]) then
					arg_271_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1042ui_story"]) and arg_271_1.var_.characterEffect1042ui_story then
				arg_271_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_274_2 = 0
			local var_274_3 = 1.475

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_4 = arg_271_1:GetWordFromCfg(1106701066)
				local var_274_5 = arg_271_1:FormatText(var_274_4.content)

				arg_271_1.text_.text = var_274_5

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_7 = 59 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 59)

				if (59 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 59)) > 0 and var_274_3 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_2
					end
				end

				arg_271_1.text_.text = var_274_5
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701066", "story_v_side_new_1106701.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701066", "story_v_side_new_1106701.awb") / 1000

					if var_274_8 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_2
					end

					if var_274_4.prefab_name ~= "" and arg_271_1.actors_[var_274_4.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_4.prefab_name].transform, "story_v_side_new_1106701", "1106701066", "story_v_side_new_1106701.awb")

						arg_271_1:RecordAudio("1106701066", var_274_9)
						arg_271_1:RecordAudio("1106701066", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701066", "story_v_side_new_1106701.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701066", "story_v_side_new_1106701.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_3, arg_271_1.talkMaxDuration)

			if var_274_2 <= arg_271_1.time_ and arg_271_1.time_ < var_274_2 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_2) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_2 + var_274_10 and arg_271_1.time_ < var_274_2 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1106701067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1106701067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1106701068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1042ui_story"]) and arg_275_1.var_.characterEffect1042ui_story == nil then
				arg_275_1.var_.characterEffect1042ui_story = arg_275_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1042ui_story"]) then
				if arg_275_1.var_.characterEffect1042ui_story and not isNil(arg_275_1.actors_["1042ui_story"]) then
					arg_275_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1042ui_story"]) and arg_275_1.var_.characterEffect1042ui_story then
				arg_275_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_278_1 = 0
			local var_278_2 = 0.225

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(1106701067).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 9 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 9)

				if (9 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 9)) > 0 and var_278_2 < var_278_5 then
					arg_275_1.talkMaxDuration = var_278_5

					if var_278_5 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_6 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_6 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_6

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_6 and arg_275_1.time_ < var_278_1 + var_278_6 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1106701068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1106701068
		arg_279_1.duration_ = 12.4

		local var_279_0 = {
			zh = 12.4,
			ja = 9.266
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1106701069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1042ui_story"]) and arg_279_1.var_.characterEffect1042ui_story == nil then
				arg_279_1.var_.characterEffect1042ui_story = arg_279_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1042ui_story"]) then
				if arg_279_1.var_.characterEffect1042ui_story and not isNil(arg_279_1.actors_["1042ui_story"]) then
					arg_279_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1042ui_story"]) and arg_279_1.var_.characterEffect1042ui_story then
				arg_279_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action448")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_282_2 = 0
			local var_282_3 = 1.35

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_4 = arg_279_1:GetWordFromCfg(1106701068)
				local var_282_5 = arg_279_1:FormatText(var_282_4.content)

				arg_279_1.text_.text = var_282_5

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_7 = 54 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 54)

				if (54 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 54)) > 0 and var_282_3 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_2
					end
				end

				arg_279_1.text_.text = var_282_5
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701068", "story_v_side_new_1106701.awb") ~= 0 then
					local var_282_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701068", "story_v_side_new_1106701.awb") / 1000

					if var_282_8 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_8 + var_282_2
					end

					if var_282_4.prefab_name ~= "" and arg_279_1.actors_[var_282_4.prefab_name] ~= nil then
						local var_282_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_4.prefab_name].transform, "story_v_side_new_1106701", "1106701068", "story_v_side_new_1106701.awb")

						arg_279_1:RecordAudio("1106701068", var_282_9)
						arg_279_1:RecordAudio("1106701068", var_282_9)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701068", "story_v_side_new_1106701.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701068", "story_v_side_new_1106701.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_10 = math.max(var_282_3, arg_279_1.talkMaxDuration)

			if var_282_2 <= arg_279_1.time_ and arg_279_1.time_ < var_282_2 + var_282_10 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_2) / var_282_10

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_2 + var_282_10 and arg_279_1.time_ < var_282_2 + var_282_10 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1106701069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1106701069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1106701070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1042ui_story"]) and arg_283_1.var_.characterEffect1042ui_story == nil then
				arg_283_1.var_.characterEffect1042ui_story = arg_283_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1042ui_story"]) then
				if arg_283_1.var_.characterEffect1042ui_story and not isNil(arg_283_1.actors_["1042ui_story"]) then
					arg_283_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_0)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1042ui_story"]) and arg_283_1.var_.characterEffect1042ui_story then
				arg_283_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_286_1 = 0
			local var_286_2 = 0.075

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(1106701069).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 3 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 3)

				if (3 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 3)) > 0 and var_286_2 < var_286_5 then
					arg_283_1.talkMaxDuration = var_286_5

					if var_286_5 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_6 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_6 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_6

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_6 and arg_283_1.time_ < var_286_1 + var_286_6 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1106701070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1106701070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1106701071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1042ui_story = arg_287_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1042ui_story"].transform.position).z)
				arg_287_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1042ui_story"].transform.localEulerAngles = arg_287_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_287_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1042ui_story"].transform.position).z)
				arg_287_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1042ui_story"].transform.localEulerAngles = arg_287_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_290_1 = 0
			local var_290_2 = 1.1

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_3 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(1106701070).content)

				arg_287_1.text_.text = var_290_3

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 44 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 44)

				if (44 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 44)) > 0 and var_290_2 < var_290_5 then
					arg_287_1.talkMaxDuration = var_290_5

					if var_290_5 + var_290_1 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + var_290_1
					end
				end

				arg_287_1.text_.text = var_290_3
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_6 = math.max(var_290_2, arg_287_1.talkMaxDuration)

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_6 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_1) / var_290_6

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_1 + var_290_6 and arg_287_1.time_ < var_290_1 + var_290_6 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play1106701071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1106701071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1106701072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.8

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(1106701071).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 32 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 32)

				if (32 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 32)) > 0 and var_294_0 < var_294_3 then
					arg_291_1.talkMaxDuration = var_294_3

					if var_294_3 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_3 + 0
					end
				end

				arg_291_1.text_.text = var_294_1
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_4 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_4

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1106701072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1106701072
		arg_295_1.duration_ = 5.27

		local var_295_0 = {
			zh = 5.266,
			ja = 4.9
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1106701073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1042ui_story = arg_295_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1042ui_story"].transform.position).z)
				arg_295_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1042ui_story"].transform.localEulerAngles = arg_295_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_295_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1042ui_story"].transform.position).z)
				arg_295_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1042ui_story"].transform.localEulerAngles = arg_295_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["1042ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1042ui_story == nil then
				arg_295_1.var_.characterEffect1042ui_story = var_298_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 and not isNil(var_298_1) then
				if arg_295_1.var_.characterEffect1042ui_story and not isNil(var_298_1) then
					arg_295_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1042ui_story then
				arg_295_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action486")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_298_4 = 0
			local var_298_5 = 0.725

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_6 = arg_295_1:GetWordFromCfg(1106701072)
				local var_298_7 = arg_295_1:FormatText(var_298_6.content)

				arg_295_1.text_.text = var_298_7

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_9 = 29 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 29)

				if (29 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 29)) > 0 and var_298_5 < var_298_9 then
					arg_295_1.talkMaxDuration = var_298_9

					if var_298_9 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_4
					end
				end

				arg_295_1.text_.text = var_298_7
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701072", "story_v_side_new_1106701.awb") ~= 0 then
					local var_298_10 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701072", "story_v_side_new_1106701.awb") / 1000

					if var_298_10 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_4
					end

					if var_298_6.prefab_name ~= "" and arg_295_1.actors_[var_298_6.prefab_name] ~= nil then
						local var_298_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_6.prefab_name].transform, "story_v_side_new_1106701", "1106701072", "story_v_side_new_1106701.awb")

						arg_295_1:RecordAudio("1106701072", var_298_11)
						arg_295_1:RecordAudio("1106701072", var_298_11)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701072", "story_v_side_new_1106701.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701072", "story_v_side_new_1106701.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_12 = math.max(var_298_5, arg_295_1.talkMaxDuration)

			if var_298_4 <= arg_295_1.time_ and arg_295_1.time_ < var_298_4 + var_298_12 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_4) / var_298_12

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_4 + var_298_12 and arg_295_1.time_ < var_298_4 + var_298_12 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play1106701073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1106701073
		arg_299_1.duration_ = 8.07

		local var_299_0 = {
			zh = 8.066,
			ja = 7.266
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1106701074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_302_0 = 0
			local var_302_1 = 0.8

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_2 = arg_299_1:GetWordFromCfg(1106701073)
				local var_302_3 = arg_299_1:FormatText(var_302_2.content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 32 <= 0 and var_302_1 or var_302_1 * (utf8.len(var_302_3) / 32)

				if (32 <= 0 and var_302_1 or var_302_1 * (utf8.len(var_302_3) / 32)) > 0 and var_302_1 < var_302_5 then
					arg_299_1.talkMaxDuration = var_302_5

					if var_302_5 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701073", "story_v_side_new_1106701.awb") ~= 0 then
					local var_302_6 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701073", "story_v_side_new_1106701.awb") / 1000

					if var_302_6 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_6 + var_302_0
					end

					if var_302_2.prefab_name ~= "" and arg_299_1.actors_[var_302_2.prefab_name] ~= nil then
						local var_302_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_2.prefab_name].transform, "story_v_side_new_1106701", "1106701073", "story_v_side_new_1106701.awb")

						arg_299_1:RecordAudio("1106701073", var_302_7)
						arg_299_1:RecordAudio("1106701073", var_302_7)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701073", "story_v_side_new_1106701.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701073", "story_v_side_new_1106701.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_8 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_8 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_8

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_8 and arg_299_1.time_ < var_302_0 + var_302_8 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1106701074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1106701074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1106701075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1042ui_story"]) and arg_303_1.var_.characterEffect1042ui_story == nil then
				arg_303_1.var_.characterEffect1042ui_story = arg_303_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1042ui_story"]) then
				if arg_303_1.var_.characterEffect1042ui_story and not isNil(arg_303_1.actors_["1042ui_story"]) then
					arg_303_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1042ui_story"]) and arg_303_1.var_.characterEffect1042ui_story then
				arg_303_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.35

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(1106701074).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 14 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 14)

				if (14 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 14)) > 0 and var_306_2 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_6 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_6 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_6

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_6 and arg_303_1.time_ < var_306_1 + var_306_6 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1106701075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1106701075
		arg_307_1.duration_ = 12.2

		local var_307_0 = {
			zh = 6.933,
			ja = 12.2
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1106701076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1042ui_story"]) and arg_307_1.var_.characterEffect1042ui_story == nil then
				arg_307_1.var_.characterEffect1042ui_story = arg_307_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1042ui_story"]) then
				if arg_307_1.var_.characterEffect1042ui_story and not isNil(arg_307_1.actors_["1042ui_story"]) then
					arg_307_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1042ui_story"]) and arg_307_1.var_.characterEffect1042ui_story then
				arg_307_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action468")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_310_2 = 0
			local var_310_3 = 0.8

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_4 = arg_307_1:GetWordFromCfg(1106701075)
				local var_310_5 = arg_307_1:FormatText(var_310_4.content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_7 = 32 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 32)

				if (32 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 32)) > 0 and var_310_3 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701075", "story_v_side_new_1106701.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701075", "story_v_side_new_1106701.awb") / 1000

					if var_310_8 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_2
					end

					if var_310_4.prefab_name ~= "" and arg_307_1.actors_[var_310_4.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_4.prefab_name].transform, "story_v_side_new_1106701", "1106701075", "story_v_side_new_1106701.awb")

						arg_307_1:RecordAudio("1106701075", var_310_9)
						arg_307_1:RecordAudio("1106701075", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701075", "story_v_side_new_1106701.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701075", "story_v_side_new_1106701.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_3, arg_307_1.talkMaxDuration)

			if var_310_2 <= arg_307_1.time_ and arg_307_1.time_ < var_310_2 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_2) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_2 + var_310_10 and arg_307_1.time_ < var_310_2 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1106701076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1106701076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1106701077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1042ui_story"]) and arg_311_1.var_.characterEffect1042ui_story == nil then
				arg_311_1.var_.characterEffect1042ui_story = arg_311_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1042ui_story"]) then
				if arg_311_1.var_.characterEffect1042ui_story and not isNil(arg_311_1.actors_["1042ui_story"]) then
					arg_311_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1042ui_story"]) and arg_311_1.var_.characterEffect1042ui_story then
				arg_311_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 0.125

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(1106701076).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 5 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 5)

				if (5 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 5)) > 0 and var_314_2 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_1
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_6 = math.max(var_314_2, arg_311_1.talkMaxDuration)

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_6 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_1) / var_314_6

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_1 + var_314_6 and arg_311_1.time_ < var_314_1 + var_314_6 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1106701077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1106701077
		arg_315_1.duration_ = 18.8

		local var_315_0 = {
			zh = 13.466,
			ja = 18.8
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1106701078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1042ui_story"]) and arg_315_1.var_.characterEffect1042ui_story == nil then
				arg_315_1.var_.characterEffect1042ui_story = arg_315_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1042ui_story"]) then
				if arg_315_1.var_.characterEffect1042ui_story and not isNil(arg_315_1.actors_["1042ui_story"]) then
					arg_315_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1042ui_story"]) and arg_315_1.var_.characterEffect1042ui_story then
				arg_315_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_2")
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_318_2 = 0
			local var_318_3 = 1.525

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_2 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_4 = arg_315_1:GetWordFromCfg(1106701077)
				local var_318_5 = arg_315_1:FormatText(var_318_4.content)

				arg_315_1.text_.text = var_318_5

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_7 = 61 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 61)

				if (61 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 61)) > 0 and var_318_3 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_2
					end
				end

				arg_315_1.text_.text = var_318_5
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701077", "story_v_side_new_1106701.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701077", "story_v_side_new_1106701.awb") / 1000

					if var_318_8 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_2
					end

					if var_318_4.prefab_name ~= "" and arg_315_1.actors_[var_318_4.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_4.prefab_name].transform, "story_v_side_new_1106701", "1106701077", "story_v_side_new_1106701.awb")

						arg_315_1:RecordAudio("1106701077", var_318_9)
						arg_315_1:RecordAudio("1106701077", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701077", "story_v_side_new_1106701.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701077", "story_v_side_new_1106701.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_3, arg_315_1.talkMaxDuration)

			if var_318_2 <= arg_315_1.time_ and arg_315_1.time_ < var_318_2 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_2) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_2 + var_318_10 and arg_315_1.time_ < var_318_2 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1106701078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1106701078
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1106701079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1042ui_story"]) and arg_319_1.var_.characterEffect1042ui_story == nil then
				arg_319_1.var_.characterEffect1042ui_story = arg_319_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1042ui_story"]) then
				if arg_319_1.var_.characterEffect1042ui_story and not isNil(arg_319_1.actors_["1042ui_story"]) then
					arg_319_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_0)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1042ui_story"]) and arg_319_1.var_.characterEffect1042ui_story then
				arg_319_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_322_1 = 0
			local var_322_2 = 0.425

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_3 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(1106701078).content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 17 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 17)

				if (17 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 17)) > 0 and var_322_2 < var_322_5 then
					arg_319_1.talkMaxDuration = var_322_5

					if var_322_5 + var_322_1 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + var_322_1
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_6 = math.max(var_322_2, arg_319_1.talkMaxDuration)

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_6 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_1) / var_322_6

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_1 + var_322_6 and arg_319_1.time_ < var_322_1 + var_322_6 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1106701079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1106701079
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1106701080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0.7

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_1 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(1106701079).content)

				arg_323_1.text_.text = var_326_1

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_3 = 28 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 28)

				if (28 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 28)) > 0 and var_326_0 < var_326_3 then
					arg_323_1.talkMaxDuration = var_326_3

					if var_326_3 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_3 + 0
					end
				end

				arg_323_1.text_.text = var_326_1
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_4 = math.max(var_326_0, arg_323_1.talkMaxDuration)

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - 0) / var_326_4

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play1106701080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1106701080
		arg_327_1.duration_ = 11.8

		local var_327_0 = {
			zh = 9.1,
			ja = 11.8
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1106701081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1042ui_story"]) and arg_327_1.var_.characterEffect1042ui_story == nil then
				arg_327_1.var_.characterEffect1042ui_story = arg_327_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1042ui_story"]) then
				if arg_327_1.var_.characterEffect1042ui_story and not isNil(arg_327_1.actors_["1042ui_story"]) then
					arg_327_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1042ui_story"]) and arg_327_1.var_.characterEffect1042ui_story then
				arg_327_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_330_2 = 0
			local var_330_3 = 0.9

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_2 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_4 = arg_327_1:GetWordFromCfg(1106701080)
				local var_330_5 = arg_327_1:FormatText(var_330_4.content)

				arg_327_1.text_.text = var_330_5

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_7 = 36 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_5) / 36)

				if (36 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_5) / 36)) > 0 and var_330_3 < var_330_7 then
					arg_327_1.talkMaxDuration = var_330_7

					if var_330_7 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_2
					end
				end

				arg_327_1.text_.text = var_330_5
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701080", "story_v_side_new_1106701.awb") ~= 0 then
					local var_330_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701080", "story_v_side_new_1106701.awb") / 1000

					if var_330_8 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_8 + var_330_2
					end

					if var_330_4.prefab_name ~= "" and arg_327_1.actors_[var_330_4.prefab_name] ~= nil then
						local var_330_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_4.prefab_name].transform, "story_v_side_new_1106701", "1106701080", "story_v_side_new_1106701.awb")

						arg_327_1:RecordAudio("1106701080", var_330_9)
						arg_327_1:RecordAudio("1106701080", var_330_9)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701080", "story_v_side_new_1106701.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701080", "story_v_side_new_1106701.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_10 = math.max(var_330_3, arg_327_1.talkMaxDuration)

			if var_330_2 <= arg_327_1.time_ and arg_327_1.time_ < var_330_2 + var_330_10 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_2) / var_330_10

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_2 + var_330_10 and arg_327_1.time_ < var_330_2 + var_330_10 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1106701081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1106701081
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1106701082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1042ui_story"]) and arg_331_1.var_.characterEffect1042ui_story == nil then
				arg_331_1.var_.characterEffect1042ui_story = arg_331_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1042ui_story"]) then
				if arg_331_1.var_.characterEffect1042ui_story and not isNil(arg_331_1.actors_["1042ui_story"]) then
					arg_331_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_0)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1042ui_story"]) and arg_331_1.var_.characterEffect1042ui_story then
				arg_331_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_334_1 = 0
			local var_334_2 = 0.2

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_3 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(1106701081).content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 8 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 8)

				if (8 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 8)) > 0 and var_334_2 < var_334_5 then
					arg_331_1.talkMaxDuration = var_334_5

					if var_334_5 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + var_334_1
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_6 = math.max(var_334_2, arg_331_1.talkMaxDuration)

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_6 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_1) / var_334_6

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_1 + var_334_6 and arg_331_1.time_ < var_334_1 + var_334_6 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1106701082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1106701082
		arg_335_1.duration_ = 17.53

		local var_335_0 = {
			zh = 6,
			ja = 17.533
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1106701083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1042ui_story"]) and arg_335_1.var_.characterEffect1042ui_story == nil then
				arg_335_1.var_.characterEffect1042ui_story = arg_335_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1042ui_story"]) then
				if arg_335_1.var_.characterEffect1042ui_story and not isNil(arg_335_1.actors_["1042ui_story"]) then
					arg_335_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1042ui_story"]) and arg_335_1.var_.characterEffect1042ui_story then
				arg_335_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_338_2 = 0
			local var_338_3 = 0.65

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_2 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_4 = arg_335_1:GetWordFromCfg(1106701082)
				local var_338_5 = arg_335_1:FormatText(var_338_4.content)

				arg_335_1.text_.text = var_338_5

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_7 = 26 <= 0 and var_338_3 or var_338_3 * (utf8.len(var_338_5) / 26)

				if (26 <= 0 and var_338_3 or var_338_3 * (utf8.len(var_338_5) / 26)) > 0 and var_338_3 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_2
					end
				end

				arg_335_1.text_.text = var_338_5
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701082", "story_v_side_new_1106701.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701082", "story_v_side_new_1106701.awb") / 1000

					if var_338_8 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_2
					end

					if var_338_4.prefab_name ~= "" and arg_335_1.actors_[var_338_4.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_4.prefab_name].transform, "story_v_side_new_1106701", "1106701082", "story_v_side_new_1106701.awb")

						arg_335_1:RecordAudio("1106701082", var_338_9)
						arg_335_1:RecordAudio("1106701082", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701082", "story_v_side_new_1106701.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701082", "story_v_side_new_1106701.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_3, arg_335_1.talkMaxDuration)

			if var_338_2 <= arg_335_1.time_ and arg_335_1.time_ < var_338_2 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_2) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_2 + var_338_10 and arg_335_1.time_ < var_338_2 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play1106701083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1106701083
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1106701084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1042ui_story"]) and arg_339_1.var_.characterEffect1042ui_story == nil then
				arg_339_1.var_.characterEffect1042ui_story = arg_339_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1042ui_story"]) then
				if arg_339_1.var_.characterEffect1042ui_story and not isNil(arg_339_1.actors_["1042ui_story"]) then
					arg_339_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_0)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1042ui_story"]) and arg_339_1.var_.characterEffect1042ui_story then
				arg_339_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_342_1 = 0
			local var_342_2 = 0.075

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_3 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(1106701083).content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 3 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 3)

				if (3 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 3)) > 0 and var_342_2 < var_342_5 then
					arg_339_1.talkMaxDuration = var_342_5

					if var_342_5 + var_342_1 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + var_342_1
					end
				end

				arg_339_1.text_.text = var_342_3
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_6 = math.max(var_342_2, arg_339_1.talkMaxDuration)

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_6 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_1) / var_342_6

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_1 + var_342_6 and arg_339_1.time_ < var_342_1 + var_342_6 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1106701084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1106701084
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1106701085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_346_0 = 0
			local var_346_1 = 0.975

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_2 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(1106701084).content)

				arg_343_1.text_.text = var_346_2

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 39 <= 0 and var_346_1 or var_346_1 * (utf8.len(var_346_2) / 39)

				if (39 <= 0 and var_346_1 or var_346_1 * (utf8.len(var_346_2) / 39)) > 0 and var_346_1 < var_346_4 then
					arg_343_1.talkMaxDuration = var_346_4

					if var_346_4 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_4 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_2
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_5 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_5 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_5

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_5 and arg_343_1.time_ < var_346_0 + var_346_5 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1106701085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1106701085
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1106701086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.9

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_1 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(1106701085).content)

				arg_347_1.text_.text = var_350_1

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_3 = 36 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_1) / 36)

				if (36 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_1) / 36)) > 0 and var_350_0 < var_350_3 then
					arg_347_1.talkMaxDuration = var_350_3

					if var_350_3 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_3 + 0
					end
				end

				arg_347_1.text_.text = var_350_1
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_4 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_4 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_4

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_4 and arg_347_1.time_ < 0 + var_350_4 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1106701086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1106701086
		arg_351_1.duration_ = 2.13

		local var_351_0 = {
			zh = 1.999999999999,
			ja = 2.133
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1106701087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1042ui_story"]) and arg_351_1.var_.characterEffect1042ui_story == nil then
				arg_351_1.var_.characterEffect1042ui_story = arg_351_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1042ui_story"]) then
				if arg_351_1.var_.characterEffect1042ui_story and not isNil(arg_351_1.actors_["1042ui_story"]) then
					arg_351_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1042ui_story"]) and arg_351_1.var_.characterEffect1042ui_story then
				arg_351_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_354_2 = 0
			local var_354_3 = 0.15

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_2 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_4 = arg_351_1:GetWordFromCfg(1106701086)
				local var_354_5 = arg_351_1:FormatText(var_354_4.content)

				arg_351_1.text_.text = var_354_5

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_7 = 6 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_5) / 6)

				if (6 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_5) / 6)) > 0 and var_354_3 < var_354_7 then
					arg_351_1.talkMaxDuration = var_354_7

					if var_354_7 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_2
					end
				end

				arg_351_1.text_.text = var_354_5
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701086", "story_v_side_new_1106701.awb") ~= 0 then
					local var_354_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701086", "story_v_side_new_1106701.awb") / 1000

					if var_354_8 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_8 + var_354_2
					end

					if var_354_4.prefab_name ~= "" and arg_351_1.actors_[var_354_4.prefab_name] ~= nil then
						local var_354_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_4.prefab_name].transform, "story_v_side_new_1106701", "1106701086", "story_v_side_new_1106701.awb")

						arg_351_1:RecordAudio("1106701086", var_354_9)
						arg_351_1:RecordAudio("1106701086", var_354_9)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701086", "story_v_side_new_1106701.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701086", "story_v_side_new_1106701.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_3, arg_351_1.talkMaxDuration)

			if var_354_2 <= arg_351_1.time_ and arg_351_1.time_ < var_354_2 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_2) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_2 + var_354_10 and arg_351_1.time_ < var_354_2 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1106701087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1106701087
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1106701088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["1042ui_story"]) and arg_355_1.var_.characterEffect1042ui_story == nil then
				arg_355_1.var_.characterEffect1042ui_story = arg_355_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["1042ui_story"]) then
				if arg_355_1.var_.characterEffect1042ui_story and not isNil(arg_355_1.actors_["1042ui_story"]) then
					arg_355_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["1042ui_story"]) and arg_355_1.var_.characterEffect1042ui_story then
				arg_355_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_358_1 = 0
			local var_358_2 = 0.4

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(1106701087).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 16 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 16)

				if (16 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 16)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1106701088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1106701088
		arg_359_1.duration_ = 3.87

		local var_359_0 = {
			zh = 3.433,
			ja = 3.866
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1106701089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1042ui_story = arg_359_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1042ui_story"].transform.position).z)
				arg_359_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1042ui_story"].transform.localEulerAngles = arg_359_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_359_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1042ui_story"].transform.position).z)
				arg_359_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1042ui_story"].transform.localEulerAngles = arg_359_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_362_1 = arg_359_1.actors_["6046_story"].transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos6046_story = var_362_1.localPosition

				local var_362_2 = GameObjectTools.GetOrAddComponent(var_362_1.gameObject, typeof(DynamicBoneHelper))

				if var_362_2 then
					var_362_2:EnableDynamicBone(false)
				end
			end

			local var_362_3 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_3 then
				var_362_1.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_359_1.time_ - 0) / var_362_3)
				var_362_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_1.position).x, (manager.ui.mainCamera.transform.position - var_362_1.position).y, (manager.ui.mainCamera.transform.position - var_362_1.position).z)
				var_362_1.localEulerAngles.z = 0
				var_362_1.localEulerAngles.x = 0
				var_362_1.localEulerAngles = var_362_1.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_3 and arg_359_1.time_ < 0 + var_362_3 + arg_362_0 then
				var_362_1.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_362_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_1.position).x, (manager.ui.mainCamera.transform.position - var_362_1.position).y, (manager.ui.mainCamera.transform.position - var_362_1.position).z)
				var_362_1.localEulerAngles.z = 0
				var_362_1.localEulerAngles.x = 0
				var_362_1.localEulerAngles = var_362_1.localEulerAngles

				local var_362_4 = GameObjectTools.GetOrAddComponent(var_362_1.gameObject, typeof(DynamicBoneHelper))

				if var_362_4 then
					var_362_4:EnableDynamicBone(true)
				end
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_362_5 = arg_359_1.actors_["6046_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_5) and arg_359_1.var_.characterEffect6046_story == nil then
				arg_359_1.var_.characterEffect6046_story = var_362_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_6 = 0.2

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_6 and not isNil(var_362_5) then
				if arg_359_1.var_.characterEffect6046_story and not isNil(var_362_5) then
					arg_359_1.var_.characterEffect6046_story.fillFlat = true
					arg_359_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_6)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_6 and arg_359_1.time_ < 0 + var_362_6 + arg_362_0 and not isNil(var_362_5) and arg_359_1.var_.characterEffect6046_story then
				arg_359_1.var_.characterEffect6046_story.fillFlat = true
				arg_359_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_362_7 = arg_359_1.actors_["6045_story"].transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos6045_story = var_362_7.localPosition

				local var_362_8 = GameObjectTools.GetOrAddComponent(var_362_7.gameObject, typeof(DynamicBoneHelper))

				if var_362_8 then
					var_362_8:EnableDynamicBone(false)
				end
			end

			local var_362_9 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_9 then
				var_362_7.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_359_1.time_ - 0) / var_362_9)
				var_362_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_7.position).x, (manager.ui.mainCamera.transform.position - var_362_7.position).y, (manager.ui.mainCamera.transform.position - var_362_7.position).z)
				var_362_7.localEulerAngles.z = 0
				var_362_7.localEulerAngles.x = 0
				var_362_7.localEulerAngles = var_362_7.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_9 and arg_359_1.time_ < 0 + var_362_9 + arg_362_0 then
				var_362_7.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_362_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_7.position).x, (manager.ui.mainCamera.transform.position - var_362_7.position).y, (manager.ui.mainCamera.transform.position - var_362_7.position).z)
				var_362_7.localEulerAngles.z = 0
				var_362_7.localEulerAngles.x = 0
				var_362_7.localEulerAngles = var_362_7.localEulerAngles

				local var_362_10 = GameObjectTools.GetOrAddComponent(var_362_7.gameObject, typeof(DynamicBoneHelper))

				if var_362_10 then
					var_362_10:EnableDynamicBone(true)
				end
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_362_11 = arg_359_1.actors_["6045_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_11) and arg_359_1.var_.characterEffect6045_story == nil then
				arg_359_1.var_.characterEffect6045_story = var_362_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_12 = 0.2

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_12 and not isNil(var_362_11) then
				if arg_359_1.var_.characterEffect6045_story and not isNil(var_362_11) then
					arg_359_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_12 and arg_359_1.time_ < 0 + var_362_12 + arg_362_0 and not isNil(var_362_11) and arg_359_1.var_.characterEffect6045_story then
				arg_359_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_362_14 = 0
			local var_362_15 = 0.3

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_14 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_16 = arg_359_1:GetWordFromCfg(1106701088)
				local var_362_17 = arg_359_1:FormatText(var_362_16.content)

				arg_359_1.text_.text = var_362_17

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_19 = 12 <= 0 and var_362_15 or var_362_15 * (utf8.len(var_362_17) / 12)

				if (12 <= 0 and var_362_15 or var_362_15 * (utf8.len(var_362_17) / 12)) > 0 and var_362_15 < var_362_19 then
					arg_359_1.talkMaxDuration = var_362_19

					if var_362_19 + var_362_14 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_19 + var_362_14
					end
				end

				arg_359_1.text_.text = var_362_17
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701088", "story_v_side_new_1106701.awb") ~= 0 then
					local var_362_20 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701088", "story_v_side_new_1106701.awb") / 1000

					if var_362_20 + var_362_14 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_20 + var_362_14
					end

					if var_362_16.prefab_name ~= "" and arg_359_1.actors_[var_362_16.prefab_name] ~= nil then
						local var_362_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_16.prefab_name].transform, "story_v_side_new_1106701", "1106701088", "story_v_side_new_1106701.awb")

						arg_359_1:RecordAudio("1106701088", var_362_21)
						arg_359_1:RecordAudio("1106701088", var_362_21)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701088", "story_v_side_new_1106701.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701088", "story_v_side_new_1106701.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_22 = math.max(var_362_15, arg_359_1.talkMaxDuration)

			if var_362_14 <= arg_359_1.time_ and arg_359_1.time_ < var_362_14 + var_362_22 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_14) / var_362_22

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_14 + var_362_22 and arg_359_1.time_ < var_362_14 + var_362_22 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play1106701089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1106701089
		arg_363_1.duration_ = 3.77

		local var_363_0 = {
			zh = 2.966,
			ja = 3.766
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1106701090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["6046_story"]) and arg_363_1.var_.characterEffect6046_story == nil then
				arg_363_1.var_.characterEffect6046_story = arg_363_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["6046_story"]) then
				if arg_363_1.var_.characterEffect6046_story and not isNil(arg_363_1.actors_["6046_story"]) then
					arg_363_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["6046_story"]) and arg_363_1.var_.characterEffect6046_story then
				arg_363_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_366_2 = arg_363_1.actors_["6045_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_2) and arg_363_1.var_.characterEffect6045_story == nil then
				arg_363_1.var_.characterEffect6045_story = var_366_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_3 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_3 and not isNil(var_366_2) then
				if arg_363_1.var_.characterEffect6045_story and not isNil(var_366_2) then
					arg_363_1.var_.characterEffect6045_story.fillFlat = true
					arg_363_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_3)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_3 and arg_363_1.time_ < 0 + var_366_3 + arg_366_0 and not isNil(var_366_2) and arg_363_1.var_.characterEffect6045_story then
				arg_363_1.var_.characterEffect6045_story.fillFlat = true
				arg_363_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_366_4 = 0
			local var_366_5 = 0.3

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_4 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_6 = arg_363_1:GetWordFromCfg(1106701089)
				local var_366_7 = arg_363_1:FormatText(var_366_6.content)

				arg_363_1.text_.text = var_366_7

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_9 = 12 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 12)

				if (12 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 12)) > 0 and var_366_5 < var_366_9 then
					arg_363_1.talkMaxDuration = var_366_9

					if var_366_9 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_9 + var_366_4
					end
				end

				arg_363_1.text_.text = var_366_7
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701089", "story_v_side_new_1106701.awb") ~= 0 then
					local var_366_10 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701089", "story_v_side_new_1106701.awb") / 1000

					if var_366_10 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_10 + var_366_4
					end

					if var_366_6.prefab_name ~= "" and arg_363_1.actors_[var_366_6.prefab_name] ~= nil then
						local var_366_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_6.prefab_name].transform, "story_v_side_new_1106701", "1106701089", "story_v_side_new_1106701.awb")

						arg_363_1:RecordAudio("1106701089", var_366_11)
						arg_363_1:RecordAudio("1106701089", var_366_11)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701089", "story_v_side_new_1106701.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701089", "story_v_side_new_1106701.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_12 = math.max(var_366_5, arg_363_1.talkMaxDuration)

			if var_366_4 <= arg_363_1.time_ and arg_363_1.time_ < var_366_4 + var_366_12 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_4) / var_366_12

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_4 + var_366_12 and arg_363_1.time_ < var_366_4 + var_366_12 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1106701090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1106701090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1106701091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["6046_story"]) and arg_367_1.var_.characterEffect6046_story == nil then
				arg_367_1.var_.characterEffect6046_story = arg_367_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["6046_story"]) then
				if arg_367_1.var_.characterEffect6046_story and not isNil(arg_367_1.actors_["6046_story"]) then
					arg_367_1.var_.characterEffect6046_story.fillFlat = true
					arg_367_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_0)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["6046_story"]) and arg_367_1.var_.characterEffect6046_story then
				arg_367_1.var_.characterEffect6046_story.fillFlat = true
				arg_367_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_370_1 = 0
			local var_370_2 = 1.2

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(1106701090).content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 48 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_3) / 48)

				if (48 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_3) / 48)) > 0 and var_370_2 < var_370_5 then
					arg_367_1.talkMaxDuration = var_370_5

					if var_370_5 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + var_370_1
					end
				end

				arg_367_1.text_.text = var_370_3
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_6 = math.max(var_370_2, arg_367_1.talkMaxDuration)

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_6 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_1) / var_370_6

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_1 + var_370_6 and arg_367_1.time_ < var_370_1 + var_370_6 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1106701091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1106701091
		arg_371_1.duration_ = 10.43

		local var_371_0 = {
			zh = 6.4,
			ja = 10.433
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1106701092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1042ui_story = arg_371_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1042ui_story"].transform.position).z)
				arg_371_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1042ui_story"].transform.localEulerAngles = arg_371_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_371_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1042ui_story"].transform.position).z)
				arg_371_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1042ui_story"].transform.localEulerAngles = arg_371_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_374_1 = arg_371_1.actors_["6046_story"].transform

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos6046_story = var_374_1.localPosition

				local var_374_2 = GameObjectTools.GetOrAddComponent(var_374_1.gameObject, typeof(DynamicBoneHelper))

				if var_374_2 then
					var_374_2:EnableDynamicBone(false)
				end
			end

			local var_374_3 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_3 then
				var_374_1.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_371_1.time_ - 0) / var_374_3)
				var_374_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_374_1.position).x, (manager.ui.mainCamera.transform.position - var_374_1.position).y, (manager.ui.mainCamera.transform.position - var_374_1.position).z)
				var_374_1.localEulerAngles.z = 0
				var_374_1.localEulerAngles.x = 0
				var_374_1.localEulerAngles = var_374_1.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_3 and arg_371_1.time_ < 0 + var_374_3 + arg_374_0 then
				var_374_1.localPosition = Vector3.New(0, 100, 0)
				var_374_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_374_1.position).x, (manager.ui.mainCamera.transform.position - var_374_1.position).y, (manager.ui.mainCamera.transform.position - var_374_1.position).z)
				var_374_1.localEulerAngles.z = 0
				var_374_1.localEulerAngles.x = 0
				var_374_1.localEulerAngles = var_374_1.localEulerAngles

				local var_374_4 = GameObjectTools.GetOrAddComponent(var_374_1.gameObject, typeof(DynamicBoneHelper))

				if var_374_4 then
					var_374_4:EnableDynamicBone(true)
				end
			end

			local var_374_5 = arg_371_1.actors_["6045_story"].transform

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos6045_story = var_374_5.localPosition

				local var_374_6 = GameObjectTools.GetOrAddComponent(var_374_5.gameObject, typeof(DynamicBoneHelper))

				if var_374_6 then
					var_374_6:EnableDynamicBone(false)
				end
			end

			local var_374_7 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_7 then
				var_374_5.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_371_1.time_ - 0) / var_374_7)
				var_374_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_374_5.position).x, (manager.ui.mainCamera.transform.position - var_374_5.position).y, (manager.ui.mainCamera.transform.position - var_374_5.position).z)
				var_374_5.localEulerAngles.z = 0
				var_374_5.localEulerAngles.x = 0
				var_374_5.localEulerAngles = var_374_5.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_7 and arg_371_1.time_ < 0 + var_374_7 + arg_374_0 then
				var_374_5.localPosition = Vector3.New(0, 100, 0)
				var_374_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_374_5.position).x, (manager.ui.mainCamera.transform.position - var_374_5.position).y, (manager.ui.mainCamera.transform.position - var_374_5.position).z)
				var_374_5.localEulerAngles.z = 0
				var_374_5.localEulerAngles.x = 0
				var_374_5.localEulerAngles = var_374_5.localEulerAngles

				local var_374_8 = GameObjectTools.GetOrAddComponent(var_374_5.gameObject, typeof(DynamicBoneHelper))

				if var_374_8 then
					var_374_8:EnableDynamicBone(true)
				end
			end

			local var_374_9 = arg_371_1.actors_["1042ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1042ui_story == nil then
				arg_371_1.var_.characterEffect1042ui_story = var_374_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_10 = 0.2

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_10 and not isNil(var_374_9) then
				if arg_371_1.var_.characterEffect1042ui_story and not isNil(var_374_9) then
					arg_371_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_10 and arg_371_1.time_ < 0 + var_374_10 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1042ui_story then
				arg_371_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_1")
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_374_12 = 0
			local var_374_13 = 0.85

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_12 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_14 = arg_371_1:GetWordFromCfg(1106701091)
				local var_374_15 = arg_371_1:FormatText(var_374_14.content)

				arg_371_1.text_.text = var_374_15

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_17 = 35 <= 0 and var_374_13 or var_374_13 * (utf8.len(var_374_15) / 35)

				if (35 <= 0 and var_374_13 or var_374_13 * (utf8.len(var_374_15) / 35)) > 0 and var_374_13 < var_374_17 then
					arg_371_1.talkMaxDuration = var_374_17

					if var_374_17 + var_374_12 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_17 + var_374_12
					end
				end

				arg_371_1.text_.text = var_374_15
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701091", "story_v_side_new_1106701.awb") ~= 0 then
					local var_374_18 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701091", "story_v_side_new_1106701.awb") / 1000

					if var_374_18 + var_374_12 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_18 + var_374_12
					end

					if var_374_14.prefab_name ~= "" and arg_371_1.actors_[var_374_14.prefab_name] ~= nil then
						local var_374_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_14.prefab_name].transform, "story_v_side_new_1106701", "1106701091", "story_v_side_new_1106701.awb")

						arg_371_1:RecordAudio("1106701091", var_374_19)
						arg_371_1:RecordAudio("1106701091", var_374_19)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701091", "story_v_side_new_1106701.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701091", "story_v_side_new_1106701.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_20 = math.max(var_374_13, arg_371_1.talkMaxDuration)

			if var_374_12 <= arg_371_1.time_ and arg_371_1.time_ < var_374_12 + var_374_20 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_12) / var_374_20

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_12 + var_374_20 and arg_371_1.time_ < var_374_12 + var_374_20 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play1106701092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1106701092
		arg_375_1.duration_ = 12.47

		local var_375_0 = {
			zh = 5.833,
			ja = 12.466
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1106701093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_378_0 = 0
			local var_378_1 = 0.65

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_2 = arg_375_1:GetWordFromCfg(1106701092)
				local var_378_3 = arg_375_1:FormatText(var_378_2.content)

				arg_375_1.text_.text = var_378_3

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 26 <= 0 and var_378_1 or var_378_1 * (utf8.len(var_378_3) / 26)

				if (26 <= 0 and var_378_1 or var_378_1 * (utf8.len(var_378_3) / 26)) > 0 and var_378_1 < var_378_5 then
					arg_375_1.talkMaxDuration = var_378_5

					if var_378_5 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + var_378_0
					end
				end

				arg_375_1.text_.text = var_378_3
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701092", "story_v_side_new_1106701.awb") ~= 0 then
					local var_378_6 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701092", "story_v_side_new_1106701.awb") / 1000

					if var_378_6 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_6 + var_378_0
					end

					if var_378_2.prefab_name ~= "" and arg_375_1.actors_[var_378_2.prefab_name] ~= nil then
						local var_378_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_2.prefab_name].transform, "story_v_side_new_1106701", "1106701092", "story_v_side_new_1106701.awb")

						arg_375_1:RecordAudio("1106701092", var_378_7)
						arg_375_1:RecordAudio("1106701092", var_378_7)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701092", "story_v_side_new_1106701.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701092", "story_v_side_new_1106701.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_8 = math.max(var_378_1, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_8 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_0) / var_378_8

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_8 and arg_375_1.time_ < var_378_0 + var_378_8 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1106701093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1106701093
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1106701094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["1042ui_story"]) and arg_379_1.var_.characterEffect1042ui_story == nil then
				arg_379_1.var_.characterEffect1042ui_story = arg_379_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.2

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["1042ui_story"]) then
				if arg_379_1.var_.characterEffect1042ui_story and not isNil(arg_379_1.actors_["1042ui_story"]) then
					arg_379_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_0)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["1042ui_story"]) and arg_379_1.var_.characterEffect1042ui_story then
				arg_379_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_382_1 = 0
			local var_382_2 = 0.375

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_3 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(1106701093).content)

				arg_379_1.text_.text = var_382_3

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 15 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_3) / 15)

				if (15 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_3) / 15)) > 0 and var_382_2 < var_382_5 then
					arg_379_1.talkMaxDuration = var_382_5

					if var_382_5 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + var_382_1
					end
				end

				arg_379_1.text_.text = var_382_3
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_6 = math.max(var_382_2, arg_379_1.talkMaxDuration)

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_6 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_1) / var_382_6

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_1 + var_382_6 and arg_379_1.time_ < var_382_1 + var_382_6 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1106701094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1106701094
		arg_383_1.duration_ = 1

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"

			SetActive(arg_383_1.choicesGo_, true)

			for iter_384_0, iter_384_1 in ipairs(arg_383_1.choices_) do
				SetActive(iter_384_1.go, iter_384_0 <= 2)
			end

			arg_383_1.choices_[1].txt.text = arg_383_1:FormatText(StoryChoiceCfg[376].name)
			arg_383_1.choices_[2].txt.text = arg_383_1:FormatText(StoryChoiceCfg[377].name)
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1106701095(arg_383_1)
			end

			if arg_385_0 == 2 then
				arg_383_0:Play1106701095(arg_383_1)
			end

			arg_383_1:RecordChoiceLog(1106701094, 376, 377)
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.allBtn_.enabled = false
			end

			if arg_383_1.time_ >= 0 + 0.5 and arg_383_1.time_ < 0 + 0.5 + arg_386_0 then
				arg_383_1.allBtn_.enabled = true
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1106701095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1106701095
		arg_387_1.duration_ = 3.47

		local var_387_0 = {
			zh = 2.233,
			ja = 3.466
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1106701096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["1042ui_story"]) and arg_387_1.var_.characterEffect1042ui_story == nil then
				arg_387_1.var_.characterEffect1042ui_story = arg_387_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_0 = 0.2

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["1042ui_story"]) then
				if arg_387_1.var_.characterEffect1042ui_story and not isNil(arg_387_1.actors_["1042ui_story"]) then
					arg_387_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["1042ui_story"]) and arg_387_1.var_.characterEffect1042ui_story then
				arg_387_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_390_2 = "1042ui_story"

			if arg_387_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_390_3 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_387_1.stage_.transform)

				var_390_3.name = var_390_2
				var_390_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_387_1.actors_[var_390_2] = var_390_3

				local var_390_4 = var_390_3:GetComponentInChildren(typeof(CharacterEffect))

				var_390_4.enabled = true

				local var_390_5 = GameObjectTools.GetOrAddComponent(var_390_3, typeof(DynamicBoneHelper))

				if var_390_5 then
					var_390_5:EnableDynamicBone(false)
				end

				arg_387_1:ShowWeapon(var_390_4.transform, false)

				arg_387_1.var_[var_390_2 .. "Animator"] = var_390_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_387_1.var_[var_390_2 .. "Animator"].applyRootMotion = true
				arg_387_1.var_[var_390_2 .. "LipSync"] = var_390_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_2")
			end

			local var_390_6 = "1042ui_story"

			if arg_387_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_390_7 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_387_1.stage_.transform)

				var_390_7.name = var_390_6
				var_390_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_387_1.actors_[var_390_6] = var_390_7

				local var_390_8 = var_390_7:GetComponentInChildren(typeof(CharacterEffect))

				var_390_8.enabled = true

				local var_390_9 = GameObjectTools.GetOrAddComponent(var_390_7, typeof(DynamicBoneHelper))

				if var_390_9 then
					var_390_9:EnableDynamicBone(false)
				end

				arg_387_1:ShowWeapon(var_390_8.transform, false)

				arg_387_1.var_[var_390_6 .. "Animator"] = var_390_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_387_1.var_[var_390_6 .. "Animator"].applyRootMotion = true
				arg_387_1.var_[var_390_6 .. "LipSync"] = var_390_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_390_10 = 0
			local var_390_11 = 0.25

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_10 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_12 = arg_387_1:GetWordFromCfg(1106701095)
				local var_390_13 = arg_387_1:FormatText(var_390_12.content)

				arg_387_1.text_.text = var_390_13

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_15 = 10 <= 0 and var_390_11 or var_390_11 * (utf8.len(var_390_13) / 10)

				if (10 <= 0 and var_390_11 or var_390_11 * (utf8.len(var_390_13) / 10)) > 0 and var_390_11 < var_390_15 then
					arg_387_1.talkMaxDuration = var_390_15

					if var_390_15 + var_390_10 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_15 + var_390_10
					end
				end

				arg_387_1.text_.text = var_390_13
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701095", "story_v_side_new_1106701.awb") ~= 0 then
					local var_390_16 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701095", "story_v_side_new_1106701.awb") / 1000

					if var_390_16 + var_390_10 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_16 + var_390_10
					end

					if var_390_12.prefab_name ~= "" and arg_387_1.actors_[var_390_12.prefab_name] ~= nil then
						local var_390_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_12.prefab_name].transform, "story_v_side_new_1106701", "1106701095", "story_v_side_new_1106701.awb")

						arg_387_1:RecordAudio("1106701095", var_390_17)
						arg_387_1:RecordAudio("1106701095", var_390_17)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701095", "story_v_side_new_1106701.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701095", "story_v_side_new_1106701.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_18 = math.max(var_390_11, arg_387_1.talkMaxDuration)

			if var_390_10 <= arg_387_1.time_ and arg_387_1.time_ < var_390_10 + var_390_18 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_10) / var_390_18

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_10 + var_390_18 and arg_387_1.time_ < var_390_10 + var_390_18 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1106701096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1106701096
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1106701097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1042ui_story"]) and arg_391_1.var_.characterEffect1042ui_story == nil then
				arg_391_1.var_.characterEffect1042ui_story = arg_391_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.2

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1042ui_story"]) then
				if arg_391_1.var_.characterEffect1042ui_story and not isNil(arg_391_1.actors_["1042ui_story"]) then
					arg_391_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_0)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1042ui_story"]) and arg_391_1.var_.characterEffect1042ui_story then
				arg_391_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_394_1 = 0
			local var_394_2 = 0.1

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_3 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(1106701096).content)

				arg_391_1.text_.text = var_394_3

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 4 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 4)

				if (4 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 4)) > 0 and var_394_2 < var_394_5 then
					arg_391_1.talkMaxDuration = var_394_5

					if var_394_5 + var_394_1 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + var_394_1
					end
				end

				arg_391_1.text_.text = var_394_3
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_6 = math.max(var_394_2, arg_391_1.talkMaxDuration)

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_6 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_1) / var_394_6

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_1 + var_394_6 and arg_391_1.time_ < var_394_1 + var_394_6 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1106701097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1106701097
		arg_395_1.duration_ = 11.53

		local var_395_0 = {
			zh = 8.033,
			ja = 11.533
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1106701098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["1042ui_story"]) and arg_395_1.var_.characterEffect1042ui_story == nil then
				arg_395_1.var_.characterEffect1042ui_story = arg_395_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_0 = 0.2

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["1042ui_story"]) then
				if arg_395_1.var_.characterEffect1042ui_story and not isNil(arg_395_1.actors_["1042ui_story"]) then
					arg_395_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["1042ui_story"]) and arg_395_1.var_.characterEffect1042ui_story then
				arg_395_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action3_1")
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_398_2 = 0
			local var_398_3 = 0.95

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_2 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_4 = arg_395_1:GetWordFromCfg(1106701097)
				local var_398_5 = arg_395_1:FormatText(var_398_4.content)

				arg_395_1.text_.text = var_398_5

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_7 = 38 <= 0 and var_398_3 or var_398_3 * (utf8.len(var_398_5) / 38)

				if (38 <= 0 and var_398_3 or var_398_3 * (utf8.len(var_398_5) / 38)) > 0 and var_398_3 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_2
					end
				end

				arg_395_1.text_.text = var_398_5
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701097", "story_v_side_new_1106701.awb") ~= 0 then
					local var_398_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701097", "story_v_side_new_1106701.awb") / 1000

					if var_398_8 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_8 + var_398_2
					end

					if var_398_4.prefab_name ~= "" and arg_395_1.actors_[var_398_4.prefab_name] ~= nil then
						local var_398_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_4.prefab_name].transform, "story_v_side_new_1106701", "1106701097", "story_v_side_new_1106701.awb")

						arg_395_1:RecordAudio("1106701097", var_398_9)
						arg_395_1:RecordAudio("1106701097", var_398_9)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701097", "story_v_side_new_1106701.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701097", "story_v_side_new_1106701.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_10 = math.max(var_398_3, arg_395_1.talkMaxDuration)

			if var_398_2 <= arg_395_1.time_ and arg_395_1.time_ < var_398_2 + var_398_10 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_2) / var_398_10

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_2 + var_398_10 and arg_395_1.time_ < var_398_2 + var_398_10 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1106701098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1106701098
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1106701099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1042ui_story"]) and arg_399_1.var_.characterEffect1042ui_story == nil then
				arg_399_1.var_.characterEffect1042ui_story = arg_399_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.2

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1042ui_story"]) then
				if arg_399_1.var_.characterEffect1042ui_story and not isNil(arg_399_1.actors_["1042ui_story"]) then
					arg_399_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 0) / var_402_0)
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1042ui_story"]) and arg_399_1.var_.characterEffect1042ui_story then
				arg_399_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_402_1 = 0
			local var_402_2 = 0.075

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_3 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(1106701098).content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 3 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 3)

				if (3 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 3)) > 0 and var_402_2 < var_402_5 then
					arg_399_1.talkMaxDuration = var_402_5

					if var_402_5 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + var_402_1
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_6 = math.max(var_402_2, arg_399_1.talkMaxDuration)

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_6 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_1) / var_402_6

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_1 + var_402_6 and arg_399_1.time_ < var_402_1 + var_402_6 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1106701099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1106701099
		arg_403_1.duration_ = 9.83

		local var_403_0 = {
			zh = 5.333,
			ja = 9.833
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1106701100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["1042ui_story"]) and arg_403_1.var_.characterEffect1042ui_story == nil then
				arg_403_1.var_.characterEffect1042ui_story = arg_403_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_0 = 0.2

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["1042ui_story"]) then
				if arg_403_1.var_.characterEffect1042ui_story and not isNil(arg_403_1.actors_["1042ui_story"]) then
					arg_403_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["1042ui_story"]) and arg_403_1.var_.characterEffect1042ui_story then
				arg_403_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action439")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_406_2 = 0
			local var_406_3 = 0.575

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_2 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_4 = arg_403_1:GetWordFromCfg(1106701099)
				local var_406_5 = arg_403_1:FormatText(var_406_4.content)

				arg_403_1.text_.text = var_406_5

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_7 = 23 <= 0 and var_406_3 or var_406_3 * (utf8.len(var_406_5) / 23)

				if (23 <= 0 and var_406_3 or var_406_3 * (utf8.len(var_406_5) / 23)) > 0 and var_406_3 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_2 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_2
					end
				end

				arg_403_1.text_.text = var_406_5
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701099", "story_v_side_new_1106701.awb") ~= 0 then
					local var_406_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701099", "story_v_side_new_1106701.awb") / 1000

					if var_406_8 + var_406_2 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_2
					end

					if var_406_4.prefab_name ~= "" and arg_403_1.actors_[var_406_4.prefab_name] ~= nil then
						local var_406_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_4.prefab_name].transform, "story_v_side_new_1106701", "1106701099", "story_v_side_new_1106701.awb")

						arg_403_1:RecordAudio("1106701099", var_406_9)
						arg_403_1:RecordAudio("1106701099", var_406_9)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701099", "story_v_side_new_1106701.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701099", "story_v_side_new_1106701.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_10 = math.max(var_406_3, arg_403_1.talkMaxDuration)

			if var_406_2 <= arg_403_1.time_ and arg_403_1.time_ < var_406_2 + var_406_10 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_2) / var_406_10

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_2 + var_406_10 and arg_403_1.time_ < var_406_2 + var_406_10 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1106701100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1106701100
		arg_407_1.duration_ = 8.6

		local var_407_0 = {
			zh = 3.266,
			ja = 8.6
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1106701101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action494")
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_410_0 = 0
			local var_410_1 = 0.4

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_2 = arg_407_1:GetWordFromCfg(1106701100)
				local var_410_3 = arg_407_1:FormatText(var_410_2.content)

				arg_407_1.text_.text = var_410_3

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 16 <= 0 and var_410_1 or var_410_1 * (utf8.len(var_410_3) / 16)

				if (16 <= 0 and var_410_1 or var_410_1 * (utf8.len(var_410_3) / 16)) > 0 and var_410_1 < var_410_5 then
					arg_407_1.talkMaxDuration = var_410_5

					if var_410_5 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + var_410_0
					end
				end

				arg_407_1.text_.text = var_410_3
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701100", "story_v_side_new_1106701.awb") ~= 0 then
					local var_410_6 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701100", "story_v_side_new_1106701.awb") / 1000

					if var_410_6 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_6 + var_410_0
					end

					if var_410_2.prefab_name ~= "" and arg_407_1.actors_[var_410_2.prefab_name] ~= nil then
						local var_410_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_2.prefab_name].transform, "story_v_side_new_1106701", "1106701100", "story_v_side_new_1106701.awb")

						arg_407_1:RecordAudio("1106701100", var_410_7)
						arg_407_1:RecordAudio("1106701100", var_410_7)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701100", "story_v_side_new_1106701.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701100", "story_v_side_new_1106701.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_8 = math.max(var_410_1, arg_407_1.talkMaxDuration)

			if var_410_0 <= arg_407_1.time_ and arg_407_1.time_ < var_410_0 + var_410_8 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_0) / var_410_8

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_0 + var_410_8 and arg_407_1.time_ < var_410_0 + var_410_8 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1106701101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1106701101
		arg_411_1.duration_ = 12.07

		local var_411_0 = {
			zh = 5.7,
			ja = 12.066
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1106701102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action443")
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_414_0 = 0
			local var_414_1 = 0.65

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_2 = arg_411_1:GetWordFromCfg(1106701101)
				local var_414_3 = arg_411_1:FormatText(var_414_2.content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 26 <= 0 and var_414_1 or var_414_1 * (utf8.len(var_414_3) / 26)

				if (26 <= 0 and var_414_1 or var_414_1 * (utf8.len(var_414_3) / 26)) > 0 and var_414_1 < var_414_5 then
					arg_411_1.talkMaxDuration = var_414_5

					if var_414_5 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + var_414_0
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701101", "story_v_side_new_1106701.awb") ~= 0 then
					local var_414_6 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701101", "story_v_side_new_1106701.awb") / 1000

					if var_414_6 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_6 + var_414_0
					end

					if var_414_2.prefab_name ~= "" and arg_411_1.actors_[var_414_2.prefab_name] ~= nil then
						local var_414_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_2.prefab_name].transform, "story_v_side_new_1106701", "1106701101", "story_v_side_new_1106701.awb")

						arg_411_1:RecordAudio("1106701101", var_414_7)
						arg_411_1:RecordAudio("1106701101", var_414_7)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701101", "story_v_side_new_1106701.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701101", "story_v_side_new_1106701.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_8 = math.max(var_414_1, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_8 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_0) / var_414_8

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_8 and arg_411_1.time_ < var_414_0 + var_414_8 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1106701102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1106701102
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1106701103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["1042ui_story"]) and arg_415_1.var_.characterEffect1042ui_story == nil then
				arg_415_1.var_.characterEffect1042ui_story = arg_415_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_0 = 0.2

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["1042ui_story"]) then
				if arg_415_1.var_.characterEffect1042ui_story and not isNil(arg_415_1.actors_["1042ui_story"]) then
					arg_415_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0) / var_418_0)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["1042ui_story"]) and arg_415_1.var_.characterEffect1042ui_story then
				arg_415_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_418_1 = 0
			local var_418_2 = 0.45

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_3 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(1106701102).content)

				arg_415_1.text_.text = var_418_3

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 18 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_3) / 18)

				if (18 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_3) / 18)) > 0 and var_418_2 < var_418_5 then
					arg_415_1.talkMaxDuration = var_418_5

					if var_418_5 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + var_418_1
					end
				end

				arg_415_1.text_.text = var_418_3
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_6 = math.max(var_418_2, arg_415_1.talkMaxDuration)

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_6 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_1) / var_418_6

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_1 + var_418_6 and arg_415_1.time_ < var_418_1 + var_418_6 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play1106701103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1106701103
		arg_419_1.duration_ = 7.47

		local var_419_0 = {
			zh = 6.8,
			ja = 7.466
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1106701104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["1042ui_story"]) and arg_419_1.var_.characterEffect1042ui_story == nil then
				arg_419_1.var_.characterEffect1042ui_story = arg_419_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_0 = 0.2

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["1042ui_story"]) then
				if arg_419_1.var_.characterEffect1042ui_story and not isNil(arg_419_1.actors_["1042ui_story"]) then
					arg_419_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["1042ui_story"]) and arg_419_1.var_.characterEffect1042ui_story then
				arg_419_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action438")
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_422_2 = 0
			local var_422_3 = 0.825

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_2 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_4 = arg_419_1:GetWordFromCfg(1106701103)
				local var_422_5 = arg_419_1:FormatText(var_422_4.content)

				arg_419_1.text_.text = var_422_5

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_7 = 33 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_5) / 33)

				if (33 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_5) / 33)) > 0 and var_422_3 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_2
					end
				end

				arg_419_1.text_.text = var_422_5
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701103", "story_v_side_new_1106701.awb") ~= 0 then
					local var_422_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701103", "story_v_side_new_1106701.awb") / 1000

					if var_422_8 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_2
					end

					if var_422_4.prefab_name ~= "" and arg_419_1.actors_[var_422_4.prefab_name] ~= nil then
						local var_422_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_4.prefab_name].transform, "story_v_side_new_1106701", "1106701103", "story_v_side_new_1106701.awb")

						arg_419_1:RecordAudio("1106701103", var_422_9)
						arg_419_1:RecordAudio("1106701103", var_422_9)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701103", "story_v_side_new_1106701.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701103", "story_v_side_new_1106701.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_10 = math.max(var_422_3, arg_419_1.talkMaxDuration)

			if var_422_2 <= arg_419_1.time_ and arg_419_1.time_ < var_422_2 + var_422_10 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_2) / var_422_10

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_2 + var_422_10 and arg_419_1.time_ < var_422_2 + var_422_10 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play1106701104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1106701104
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1106701105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["1042ui_story"]) and arg_423_1.var_.characterEffect1042ui_story == nil then
				arg_423_1.var_.characterEffect1042ui_story = arg_423_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["1042ui_story"]) then
				if arg_423_1.var_.characterEffect1042ui_story and not isNil(arg_423_1.actors_["1042ui_story"]) then
					arg_423_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_0)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["1042ui_story"]) and arg_423_1.var_.characterEffect1042ui_story then
				arg_423_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_426_1 = 0
			local var_426_2 = 0.75

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_3 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(1106701104).content)

				arg_423_1.text_.text = var_426_3

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 30 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 30)

				if (30 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 30)) > 0 and var_426_2 < var_426_5 then
					arg_423_1.talkMaxDuration = var_426_5

					if var_426_5 + var_426_1 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_5 + var_426_1
					end
				end

				arg_423_1.text_.text = var_426_3
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_6 = math.max(var_426_2, arg_423_1.talkMaxDuration)

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_6 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_1) / var_426_6

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_1 + var_426_6 and arg_423_1.time_ < var_426_1 + var_426_6 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play1106701105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1106701105
		arg_427_1.duration_ = 5.23

		local var_427_0 = {
			zh = 5.233,
			ja = 4.833
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1106701106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["1042ui_story"]) and arg_427_1.var_.characterEffect1042ui_story == nil then
				arg_427_1.var_.characterEffect1042ui_story = arg_427_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.2

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["1042ui_story"]) then
				if arg_427_1.var_.characterEffect1042ui_story and not isNil(arg_427_1.actors_["1042ui_story"]) then
					arg_427_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["1042ui_story"]) and arg_427_1.var_.characterEffect1042ui_story then
				arg_427_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_430_2 = 0
			local var_430_3 = 0.35

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_2 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_4 = arg_427_1:GetWordFromCfg(1106701105)
				local var_430_5 = arg_427_1:FormatText(var_430_4.content)

				arg_427_1.text_.text = var_430_5

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_7 = 14 <= 0 and var_430_3 or var_430_3 * (utf8.len(var_430_5) / 14)

				if (14 <= 0 and var_430_3 or var_430_3 * (utf8.len(var_430_5) / 14)) > 0 and var_430_3 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_2 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_2
					end
				end

				arg_427_1.text_.text = var_430_5
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701105", "story_v_side_new_1106701.awb") ~= 0 then
					local var_430_8 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701105", "story_v_side_new_1106701.awb") / 1000

					if var_430_8 + var_430_2 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_8 + var_430_2
					end

					if var_430_4.prefab_name ~= "" and arg_427_1.actors_[var_430_4.prefab_name] ~= nil then
						local var_430_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_4.prefab_name].transform, "story_v_side_new_1106701", "1106701105", "story_v_side_new_1106701.awb")

						arg_427_1:RecordAudio("1106701105", var_430_9)
						arg_427_1:RecordAudio("1106701105", var_430_9)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701105", "story_v_side_new_1106701.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701105", "story_v_side_new_1106701.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_10 = math.max(var_430_3, arg_427_1.talkMaxDuration)

			if var_430_2 <= arg_427_1.time_ and arg_427_1.time_ < var_430_2 + var_430_10 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_2) / var_430_10

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_2 + var_430_10 and arg_427_1.time_ < var_430_2 + var_430_10 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1106701106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1106701106
		arg_431_1.duration_ = 8

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1106701107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.mask_.enabled = true
				arg_431_1.mask_.raycastTarget = true

				arg_431_1:SetGaussion(false)
			end

			local var_434_0 = 1.5

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 then
				local var_434_1 = Color.New(0, 0, 0)

				var_434_1.a = Mathf.Lerp(0, 1, (arg_431_1.time_ - 0) / var_434_0)
				arg_431_1.mask_.color = var_434_1
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 then
				local var_434_2 = Color.New(0, 0, 0)

				var_434_2.a = 1
				arg_431_1.mask_.color = var_434_2
			end

			local var_434_3 = 1.5

			if 1.5 < arg_431_1.time_ and arg_431_1.time_ <= var_434_3 + arg_434_0 then
				arg_431_1.mask_.enabled = true
				arg_431_1.mask_.raycastTarget = true

				arg_431_1:SetGaussion(false)
			end

			local var_434_4 = 1.5

			if var_434_3 <= arg_431_1.time_ and arg_431_1.time_ < var_434_3 + var_434_4 then
				local var_434_5 = Color.New(0, 0, 0)

				var_434_5.a = Mathf.Lerp(1, 0, (arg_431_1.time_ - var_434_3) / var_434_4)
				arg_431_1.mask_.color = var_434_5
			end

			if arg_431_1.time_ >= var_434_3 + var_434_4 and arg_431_1.time_ < var_434_3 + var_434_4 + arg_434_0 then
				local var_434_6 = Color.New(0, 0, 0)

				arg_431_1.mask_.enabled = false
				var_434_6.a = 0
				arg_431_1.mask_.color = var_434_6
			end

			local var_434_7 = arg_431_1.actors_["1042ui_story"].transform

			if 1.5 < arg_431_1.time_ and arg_431_1.time_ <= 1.5 + arg_434_0 then
				arg_431_1.var_.moveOldPos1042ui_story = var_434_7.localPosition
			end

			local var_434_8 = 0.001

			if 1.5 <= arg_431_1.time_ and arg_431_1.time_ < 1.5 + var_434_8 then
				var_434_7.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_431_1.time_ - 1.5) / var_434_8)
				var_434_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_434_7.position).x, (manager.ui.mainCamera.transform.position - var_434_7.position).y, (manager.ui.mainCamera.transform.position - var_434_7.position).z)
				var_434_7.localEulerAngles.z = 0
				var_434_7.localEulerAngles.x = 0
				var_434_7.localEulerAngles = var_434_7.localEulerAngles
			end

			if arg_431_1.time_ >= 1.5 + var_434_8 and arg_431_1.time_ < 1.5 + var_434_8 + arg_434_0 then
				var_434_7.localPosition = Vector3.New(0, 100, 0)
				var_434_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_434_7.position).x, (manager.ui.mainCamera.transform.position - var_434_7.position).y, (manager.ui.mainCamera.transform.position - var_434_7.position).z)
				var_434_7.localEulerAngles.z = 0
				var_434_7.localEulerAngles.x = 0
				var_434_7.localEulerAngles = var_434_7.localEulerAngles
			end

			if arg_431_1.frameCnt_ <= 1 then
				arg_431_1.dialog_:SetActive(false)
			end

			local var_434_9 = 3
			local var_434_10 = 0.75

			if 3 < arg_431_1.time_ and arg_431_1.time_ <= var_434_9 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0

				arg_431_1.dialog_:SetActive(true)

				arg_431_1.dialogCg_.alpha = 0

				local var_434_11 = LeanTween.value(arg_431_1.dialog_, 0, 1, 0.3)

				var_434_11:setOnUpdate(LuaHelper.FloatAction(function(arg_435_0)
					arg_431_1.dialogCg_.alpha = arg_435_0
				end))
				var_434_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_431_1.dialog_)
					var_434_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_431_1.duration_ = arg_431_1.duration_ + 0.3

				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_12 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(1106701106).content)

				arg_431_1.text_.text = var_434_12

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_14 = 30 <= 0 and var_434_10 or var_434_10 * (utf8.len(var_434_12) / 30)

				if (30 <= 0 and var_434_10 or var_434_10 * (utf8.len(var_434_12) / 30)) > 0 and var_434_10 < var_434_14 then
					arg_431_1.talkMaxDuration = var_434_14
					var_434_9 = var_434_9 + 0.3

					if var_434_14 + var_434_9 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_14 + var_434_9
					end
				end

				arg_431_1.text_.text = var_434_12
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_15 = var_434_9 + 0.3
			local var_434_16 = math.max(var_434_10, arg_431_1.talkMaxDuration)

			if var_434_9 + 0.3 <= arg_431_1.time_ and arg_431_1.time_ < var_434_15 + var_434_16 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_15) / var_434_16

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_15 + var_434_16 and arg_431_1.time_ < var_434_15 + var_434_16 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play1106701107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1106701107
		arg_437_1.duration_ = 2

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1106701108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos1067ui_story = arg_437_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_440_0 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 then
				arg_437_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1067ui_story, Vector3.New(0, -1.06, -6.2), (arg_437_1.time_ - 0) / var_440_0)
				arg_437_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1067ui_story"].transform.position).z)
				arg_437_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1067ui_story"].transform.localEulerAngles = arg_437_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 then
				arg_437_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_437_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1067ui_story"].transform.position).z)
				arg_437_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1067ui_story"].transform.localEulerAngles = arg_437_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_440_1 = arg_437_1.actors_["1067ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1067ui_story == nil then
				arg_437_1.var_.characterEffect1067ui_story = var_440_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.2

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_2 and not isNil(var_440_1) then
				if arg_437_1.var_.characterEffect1067ui_story and not isNil(var_440_1) then
					arg_437_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_2 and arg_437_1.time_ < 0 + var_440_2 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1067ui_story then
				arg_437_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action5_1")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_440_4 = 0
			local var_440_5 = 0.075

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_4 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_6 = arg_437_1:GetWordFromCfg(1106701107)
				local var_440_7 = arg_437_1:FormatText(var_440_6.content)

				arg_437_1.text_.text = var_440_7

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_9 = 3 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 3)

				if (3 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 3)) > 0 and var_440_5 < var_440_9 then
					arg_437_1.talkMaxDuration = var_440_9

					if var_440_9 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_9 + var_440_4
					end
				end

				arg_437_1.text_.text = var_440_7
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701107", "story_v_side_new_1106701.awb") ~= 0 then
					local var_440_10 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701107", "story_v_side_new_1106701.awb") / 1000

					if var_440_10 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_10 + var_440_4
					end

					if var_440_6.prefab_name ~= "" and arg_437_1.actors_[var_440_6.prefab_name] ~= nil then
						local var_440_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_6.prefab_name].transform, "story_v_side_new_1106701", "1106701107", "story_v_side_new_1106701.awb")

						arg_437_1:RecordAudio("1106701107", var_440_11)
						arg_437_1:RecordAudio("1106701107", var_440_11)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701107", "story_v_side_new_1106701.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701107", "story_v_side_new_1106701.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_12 = math.max(var_440_5, arg_437_1.talkMaxDuration)

			if var_440_4 <= arg_437_1.time_ and arg_437_1.time_ < var_440_4 + var_440_12 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_4) / var_440_12

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_4 + var_440_12 and arg_437_1.time_ < var_440_4 + var_440_12 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play1106701108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1106701108
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1106701109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.var_.moveOldPos1067ui_story = arg_441_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_444_0 = 0.001

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 then
				arg_441_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_441_1.time_ - 0) / var_444_0)
				arg_441_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1067ui_story"].transform.position).z)
				arg_441_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["1067ui_story"].transform.localEulerAngles = arg_441_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 then
				arg_441_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_441_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1067ui_story"].transform.position).z)
				arg_441_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["1067ui_story"].transform.localEulerAngles = arg_441_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_444_1 = 0
			local var_444_2 = 0.4

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_3 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(1106701108).content)

				arg_441_1.text_.text = var_444_3

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 16 <= 0 and var_444_2 or var_444_2 * (utf8.len(var_444_3) / 16)

				if (16 <= 0 and var_444_2 or var_444_2 * (utf8.len(var_444_3) / 16)) > 0 and var_444_2 < var_444_5 then
					arg_441_1.talkMaxDuration = var_444_5

					if var_444_5 + var_444_1 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_5 + var_444_1
					end
				end

				arg_441_1.text_.text = var_444_3
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_6 = math.max(var_444_2, arg_441_1.talkMaxDuration)

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_6 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_1) / var_444_6

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_1 + var_444_6 and arg_441_1.time_ < var_444_1 + var_444_6 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play1106701109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1106701109
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1106701110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0.1

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_1 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(1106701109).content)

				arg_445_1.text_.text = var_448_1

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_3 = 4 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_1) / 4)

				if (4 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_1) / 4)) > 0 and var_448_0 < var_448_3 then
					arg_445_1.talkMaxDuration = var_448_3

					if var_448_3 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_3 + 0
					end
				end

				arg_445_1.text_.text = var_448_1
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_4 = math.max(var_448_0, arg_445_1.talkMaxDuration)

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_4 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - 0) / var_448_4

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= 0 + var_448_4 and arg_445_1.time_ < 0 + var_448_4 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1106701110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1106701110
		arg_449_1.duration_ = 2

		local var_449_0 = {
			zh = 2,
			ja = 1.999999999999
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1106701111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["1067ui_story"]) and arg_449_1.var_.characterEffect1067ui_story == nil then
				arg_449_1.var_.characterEffect1067ui_story = arg_449_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_0 = 0.2

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["1067ui_story"]) then
				if arg_449_1.var_.characterEffect1067ui_story and not isNil(arg_449_1.actors_["1067ui_story"]) then
					arg_449_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["1067ui_story"]) and arg_449_1.var_.characterEffect1067ui_story then
				arg_449_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_452_2 = arg_449_1.actors_["1067ui_story"].transform

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos1067ui_story = var_452_2.localPosition
			end

			local var_452_3 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_3 then
				var_452_2.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1067ui_story, Vector3.New(0, -1.06, -6.2), (arg_449_1.time_ - 0) / var_452_3)
				var_452_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_452_2.position).x, (manager.ui.mainCamera.transform.position - var_452_2.position).y, (manager.ui.mainCamera.transform.position - var_452_2.position).z)
				var_452_2.localEulerAngles.z = 0
				var_452_2.localEulerAngles.x = 0
				var_452_2.localEulerAngles = var_452_2.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_3 and arg_449_1.time_ < 0 + var_452_3 + arg_452_0 then
				var_452_2.localPosition = Vector3.New(0, -1.06, -6.2)
				var_452_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_452_2.position).x, (manager.ui.mainCamera.transform.position - var_452_2.position).y, (manager.ui.mainCamera.transform.position - var_452_2.position).z)
				var_452_2.localEulerAngles.z = 0
				var_452_2.localEulerAngles.x = 0
				var_452_2.localEulerAngles = var_452_2.localEulerAngles
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			local var_452_4 = 0
			local var_452_5 = 0.25

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_4 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_6 = arg_449_1:GetWordFromCfg(1106701110)
				local var_452_7 = arg_449_1:FormatText(var_452_6.content)

				arg_449_1.text_.text = var_452_7

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_9 = 10 <= 0 and var_452_5 or var_452_5 * (utf8.len(var_452_7) / 10)

				if (10 <= 0 and var_452_5 or var_452_5 * (utf8.len(var_452_7) / 10)) > 0 and var_452_5 < var_452_9 then
					arg_449_1.talkMaxDuration = var_452_9

					if var_452_9 + var_452_4 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_9 + var_452_4
					end
				end

				arg_449_1.text_.text = var_452_7
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701110", "story_v_side_new_1106701.awb") ~= 0 then
					local var_452_10 = manager.audio:GetVoiceLength("story_v_side_new_1106701", "1106701110", "story_v_side_new_1106701.awb") / 1000

					if var_452_10 + var_452_4 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_10 + var_452_4
					end

					if var_452_6.prefab_name ~= "" and arg_449_1.actors_[var_452_6.prefab_name] ~= nil then
						local var_452_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_6.prefab_name].transform, "story_v_side_new_1106701", "1106701110", "story_v_side_new_1106701.awb")

						arg_449_1:RecordAudio("1106701110", var_452_11)
						arg_449_1:RecordAudio("1106701110", var_452_11)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_side_new_1106701", "1106701110", "story_v_side_new_1106701.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_side_new_1106701", "1106701110", "story_v_side_new_1106701.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_12 = math.max(var_452_5, arg_449_1.talkMaxDuration)

			if var_452_4 <= arg_449_1.time_ and arg_449_1.time_ < var_452_4 + var_452_12 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_4) / var_452_12

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_4 + var_452_12 and arg_449_1.time_ < var_452_4 + var_452_12 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play1106701111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1106701111
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1106701112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1067ui_story = arg_453_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1067ui_story"].transform.position).z)
				arg_453_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1067ui_story"].transform.localEulerAngles = arg_453_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_453_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1067ui_story"].transform.position).z)
				arg_453_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1067ui_story"].transform.localEulerAngles = arg_453_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_456_1 = 0
			local var_456_2 = 1.025

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_3 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(1106701111).content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 41 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_3) / 41)

				if (41 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_3) / 41)) > 0 and var_456_2 < var_456_5 then
					arg_453_1.talkMaxDuration = var_456_5

					if var_456_5 + var_456_1 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + var_456_1
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_6 = math.max(var_456_2, arg_453_1.talkMaxDuration)

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_6 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_1) / var_456_6

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_1 + var_456_6 and arg_453_1.time_ < var_456_1 + var_456_6 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play1106701112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1106701112
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
			arg_457_1.auto_ = false
		end

		function arg_457_1.playNext_(arg_459_0)
			arg_457_1.onStoryFinished_()
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0.775

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_1 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(1106701112).content)

				arg_457_1.text_.text = var_460_1

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_3 = 31 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 31)

				if (31 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 31)) > 0 and var_460_0 < var_460_3 then
					arg_457_1.talkMaxDuration = var_460_3

					if var_460_3 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_3 + 0
					end
				end

				arg_457_1.text_.text = var_460_1
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_4 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_4 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_4

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_4 and arg_457_1.time_ < 0 + var_460_4 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST22",
		"TextureConfig/Background/ST25"
	},
	voices = {
		"story_v_side_new_1106701.awb"
	}
}
