return {
	Play123541001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 123541001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play123541002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K04f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K04f")
				var_4_0.name = "K04f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K04f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K04f

				arg_1_1.bgs_.K04f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K04f" then
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

			if 1.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.83333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_4_story_wall", "bgm_activity_2_4_story_wall", "bgm_activity_2_4_story_wall.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_4_story_wall", "bgm_activity_2_4_story_wall")

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
			local var_4_15 = 0.7

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(123541001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 28 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 28)

				if (28 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 28)) > 0 and var_4_15 < var_4_19 then
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
	Play123541002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 123541002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play123541003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.25

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(123541002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 50 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 50)

				if (50 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 50)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play123541003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 123541003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play123541004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.8

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(123541003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 32 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 32)

				if (32 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 32)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play123541004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 123541004
		arg_17_1.duration_ = 5.9

		local var_17_0 = {
			zh = 5.666,
			ja = 5.9
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play123541005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1093ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1093ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1093ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1093ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1093ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1093ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1093ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1093ui_story == nil then
				arg_17_1.var_.characterEffect1093ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1093ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1093ui_story then
				arg_17_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_20_8 = "1015ui_story"

			if arg_17_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_20_9 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_17_1.stage_.transform)

				var_20_9.name = var_20_8
				var_20_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_8] = var_20_9

				local var_20_10 = var_20_9:GetComponentInChildren(typeof(CharacterEffect))

				var_20_10.enabled = true

				local var_20_11 = GameObjectTools.GetOrAddComponent(var_20_9, typeof(DynamicBoneHelper))

				if var_20_11 then
					var_20_11:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_10.transform, false)

				arg_17_1.var_[var_20_8 .. "Animator"] = var_20_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_8 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_8 .. "LipSync"] = var_20_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_12 = arg_17_1.actors_["1015ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1015ui_story = var_20_12.localPosition
			end

			local var_20_13 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_13 then
				var_20_12.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_17_1.time_ - 0) / var_20_13)
				var_20_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_12.position).x, (manager.ui.mainCamera.transform.position - var_20_12.position).y, (manager.ui.mainCamera.transform.position - var_20_12.position).z)
				var_20_12.localEulerAngles.z = 0
				var_20_12.localEulerAngles.x = 0
				var_20_12.localEulerAngles = var_20_12.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_13 and arg_17_1.time_ < 0 + var_20_13 + arg_20_0 then
				var_20_12.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_20_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_12.position).x, (manager.ui.mainCamera.transform.position - var_20_12.position).y, (manager.ui.mainCamera.transform.position - var_20_12.position).z)
				var_20_12.localEulerAngles.z = 0
				var_20_12.localEulerAngles.x = 0
				var_20_12.localEulerAngles = var_20_12.localEulerAngles
			end

			local var_20_14 = arg_17_1.actors_["1015ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1015ui_story == nil then
				arg_17_1.var_.characterEffect1015ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_15 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_15 and not isNil(var_20_14) then
				if arg_17_1.var_.characterEffect1015ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_15)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_15 and arg_17_1.time_ < 0 + var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1015ui_story then
				arg_17_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_20_16 = 0
			local var_20_17 = 0.625

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_18 = arg_17_1:GetWordFromCfg(123541004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_21 = 25 <= 0 and var_20_17 or var_20_17 * (utf8.len(var_20_19) / 25)

				if (25 <= 0 and var_20_17 or var_20_17 * (utf8.len(var_20_19) / 25)) > 0 and var_20_17 < var_20_21 then
					arg_17_1.talkMaxDuration = var_20_21

					if var_20_21 + var_20_16 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_21 + var_20_16
					end
				end

				arg_17_1.text_.text = var_20_19
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541004", "story_v_out_123541.awb") ~= 0 then
					local var_20_22 = manager.audio:GetVoiceLength("story_v_out_123541", "123541004", "story_v_out_123541.awb") / 1000

					if var_20_22 + var_20_16 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_16
					end

					if var_20_18.prefab_name ~= "" and arg_17_1.actors_[var_20_18.prefab_name] ~= nil then
						local var_20_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_18.prefab_name].transform, "story_v_out_123541", "123541004", "story_v_out_123541.awb")

						arg_17_1:RecordAudio("123541004", var_20_23)
						arg_17_1:RecordAudio("123541004", var_20_23)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_123541", "123541004", "story_v_out_123541.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_123541", "123541004", "story_v_out_123541.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_24 = math.max(var_20_17, arg_17_1.talkMaxDuration)

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_24 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_16) / var_20_24

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_16 + var_20_24 and arg_17_1.time_ < var_20_16 + var_20_24 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play123541005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 123541005
		arg_21_1.duration_ = 12.4

		local var_21_0 = {
			zh = 12.4,
			ja = 11.033
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play123541006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1015ui_story"]) and arg_21_1.var_.characterEffect1015ui_story == nil then
				arg_21_1.var_.characterEffect1015ui_story = arg_21_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1015ui_story"]) then
				if arg_21_1.var_.characterEffect1015ui_story and not isNil(arg_21_1.actors_["1015ui_story"]) then
					arg_21_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1015ui_story"]) and arg_21_1.var_.characterEffect1015ui_story then
				arg_21_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_2 = arg_21_1.actors_["1093ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1093ui_story == nil then
				arg_21_1.var_.characterEffect1093ui_story = var_24_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_3 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.characterEffect1093ui_story and not isNil(var_24_2) then
					arg_21_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_3)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1093ui_story then
				arg_21_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_24_4 = 0
			local var_24_5 = 1.575

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(123541005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 63 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 63)

				if (63 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 63)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541005", "story_v_out_123541.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_123541", "123541005", "story_v_out_123541.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_123541", "123541005", "story_v_out_123541.awb")

						arg_21_1:RecordAudio("123541005", var_24_11)
						arg_21_1:RecordAudio("123541005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_123541", "123541005", "story_v_out_123541.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_123541", "123541005", "story_v_out_123541.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play123541006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 123541006
		arg_25_1.duration_ = 5.9

		local var_25_0 = {
			zh = 2.9,
			ja = 5.9
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play123541007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1093ui_story"]) and arg_25_1.var_.characterEffect1093ui_story == nil then
				arg_25_1.var_.characterEffect1093ui_story = arg_25_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1093ui_story"]) then
				if arg_25_1.var_.characterEffect1093ui_story and not isNil(arg_25_1.actors_["1093ui_story"]) then
					arg_25_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1093ui_story"]) and arg_25_1.var_.characterEffect1093ui_story then
				arg_25_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_2 = arg_25_1.actors_["1015ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1015ui_story == nil then
				arg_25_1.var_.characterEffect1015ui_story = var_28_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.characterEffect1015ui_story and not isNil(var_28_2) then
					arg_25_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_3)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1015ui_story then
				arg_25_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_28_4 = 0
			local var_28_5 = 0.325

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(123541006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 13 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 13)

				if (13 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 13)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541006", "story_v_out_123541.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_123541", "123541006", "story_v_out_123541.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_123541", "123541006", "story_v_out_123541.awb")

						arg_25_1:RecordAudio("123541006", var_28_11)
						arg_25_1:RecordAudio("123541006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_123541", "123541006", "story_v_out_123541.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_123541", "123541006", "story_v_out_123541.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play123541007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 123541007
		arg_29_1.duration_ = 8.03

		local var_29_0 = {
			zh = 3.233,
			ja = 8.033
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play123541008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1015ui_story"]) and arg_29_1.var_.characterEffect1015ui_story == nil then
				arg_29_1.var_.characterEffect1015ui_story = arg_29_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1015ui_story"]) then
				if arg_29_1.var_.characterEffect1015ui_story and not isNil(arg_29_1.actors_["1015ui_story"]) then
					arg_29_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1015ui_story"]) and arg_29_1.var_.characterEffect1015ui_story then
				arg_29_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_2 = arg_29_1.actors_["1093ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1093ui_story == nil then
				arg_29_1.var_.characterEffect1093ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_3 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.characterEffect1093ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_3)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1093ui_story then
				arg_29_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_32_4 = 0
			local var_32_5 = 0.4

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(123541007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 16 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 16)

				if (16 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 16)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541007", "story_v_out_123541.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_123541", "123541007", "story_v_out_123541.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_123541", "123541007", "story_v_out_123541.awb")

						arg_29_1:RecordAudio("123541007", var_32_11)
						arg_29_1:RecordAudio("123541007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_123541", "123541007", "story_v_out_123541.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_123541", "123541007", "story_v_out_123541.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play123541008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 123541008
		arg_33_1.duration_ = 5.4

		local var_33_0 = {
			zh = 5.4,
			ja = 4.033
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play123541009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1093ui_story"]) and arg_33_1.var_.characterEffect1093ui_story == nil then
				arg_33_1.var_.characterEffect1093ui_story = arg_33_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1093ui_story"]) then
				if arg_33_1.var_.characterEffect1093ui_story and not isNil(arg_33_1.actors_["1093ui_story"]) then
					arg_33_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1093ui_story"]) and arg_33_1.var_.characterEffect1093ui_story then
				arg_33_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_2 = arg_33_1.actors_["1015ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1015ui_story == nil then
				arg_33_1.var_.characterEffect1015ui_story = var_36_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_3 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.characterEffect1015ui_story and not isNil(var_36_2) then
					arg_33_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_3)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1015ui_story then
				arg_33_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_36_4 = 0
			local var_36_5 = 0.575

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(123541008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 22 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 22)

				if (22 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 22)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541008", "story_v_out_123541.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_123541", "123541008", "story_v_out_123541.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_123541", "123541008", "story_v_out_123541.awb")

						arg_33_1:RecordAudio("123541008", var_36_11)
						arg_33_1:RecordAudio("123541008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_123541", "123541008", "story_v_out_123541.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_123541", "123541008", "story_v_out_123541.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play123541009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 123541009
		arg_37_1.duration_ = 4.3

		local var_37_0 = {
			zh = 3.2,
			ja = 4.3
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play123541010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1015ui_story"]) and arg_37_1.var_.characterEffect1015ui_story == nil then
				arg_37_1.var_.characterEffect1015ui_story = arg_37_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1015ui_story"]) then
				if arg_37_1.var_.characterEffect1015ui_story and not isNil(arg_37_1.actors_["1015ui_story"]) then
					arg_37_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1015ui_story"]) and arg_37_1.var_.characterEffect1015ui_story then
				arg_37_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_2 = arg_37_1.actors_["1093ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect1093ui_story == nil then
				arg_37_1.var_.characterEffect1093ui_story = var_40_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.characterEffect1093ui_story and not isNil(var_40_2) then
					arg_37_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_3)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect1093ui_story then
				arg_37_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_40_4 = 0
			local var_40_5 = 0.275

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(123541009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 11 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 11)

				if (11 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 11)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541009", "story_v_out_123541.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_123541", "123541009", "story_v_out_123541.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_123541", "123541009", "story_v_out_123541.awb")

						arg_37_1:RecordAudio("123541009", var_40_11)
						arg_37_1:RecordAudio("123541009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_123541", "123541009", "story_v_out_123541.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_123541", "123541009", "story_v_out_123541.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play123541010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 123541010
		arg_41_1.duration_ = 8.17

		local var_41_0 = {
			zh = 5.833,
			ja = 8.166
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play123541011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1093ui_story"]) and arg_41_1.var_.characterEffect1093ui_story == nil then
				arg_41_1.var_.characterEffect1093ui_story = arg_41_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1093ui_story"]) then
				if arg_41_1.var_.characterEffect1093ui_story and not isNil(arg_41_1.actors_["1093ui_story"]) then
					arg_41_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1093ui_story"]) and arg_41_1.var_.characterEffect1093ui_story then
				arg_41_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_2 = arg_41_1.actors_["1015ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1015ui_story == nil then
				arg_41_1.var_.characterEffect1015ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_3 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.characterEffect1015ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_3)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1015ui_story then
				arg_41_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_44_4 = 0
			local var_44_5 = 0.725

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(123541010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 29 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 29)

				if (29 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 29)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541010", "story_v_out_123541.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_123541", "123541010", "story_v_out_123541.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_123541", "123541010", "story_v_out_123541.awb")

						arg_41_1:RecordAudio("123541010", var_44_11)
						arg_41_1:RecordAudio("123541010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_123541", "123541010", "story_v_out_123541.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_123541", "123541010", "story_v_out_123541.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play123541011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 123541011
		arg_45_1.duration_ = 2.93

		local var_45_0 = {
			zh = 2.933,
			ja = 2.633
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play123541012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1015ui_story"]) and arg_45_1.var_.characterEffect1015ui_story == nil then
				arg_45_1.var_.characterEffect1015ui_story = arg_45_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1015ui_story"]) then
				if arg_45_1.var_.characterEffect1015ui_story and not isNil(arg_45_1.actors_["1015ui_story"]) then
					arg_45_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1015ui_story"]) and arg_45_1.var_.characterEffect1015ui_story then
				arg_45_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_48_2 = arg_45_1.actors_["1093ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect1093ui_story == nil then
				arg_45_1.var_.characterEffect1093ui_story = var_48_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_3 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.characterEffect1093ui_story and not isNil(var_48_2) then
					arg_45_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_3)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect1093ui_story then
				arg_45_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_48_4 = 0
			local var_48_5 = 0.35

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(123541011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 14 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 14)

				if (14 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 14)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541011", "story_v_out_123541.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_123541", "123541011", "story_v_out_123541.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_123541", "123541011", "story_v_out_123541.awb")

						arg_45_1:RecordAudio("123541011", var_48_11)
						arg_45_1:RecordAudio("123541011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_123541", "123541011", "story_v_out_123541.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_123541", "123541011", "story_v_out_123541.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play123541012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 123541012
		arg_49_1.duration_ = 8.7

		local var_49_0 = {
			zh = 4.433,
			ja = 8.7
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play123541013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_52_0 = 0
			local var_52_1 = 0.45

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(123541012)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 18 <= 0 and var_52_1 or var_52_1 * (utf8.len(var_52_3) / 18)

				if (18 <= 0 and var_52_1 or var_52_1 * (utf8.len(var_52_3) / 18)) > 0 and var_52_1 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541012", "story_v_out_123541.awb") ~= 0 then
					local var_52_6 = manager.audio:GetVoiceLength("story_v_out_123541", "123541012", "story_v_out_123541.awb") / 1000

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end

					if var_52_2.prefab_name ~= "" and arg_49_1.actors_[var_52_2.prefab_name] ~= nil then
						local var_52_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_2.prefab_name].transform, "story_v_out_123541", "123541012", "story_v_out_123541.awb")

						arg_49_1:RecordAudio("123541012", var_52_7)
						arg_49_1:RecordAudio("123541012", var_52_7)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_123541", "123541012", "story_v_out_123541.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_123541", "123541012", "story_v_out_123541.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_8 and arg_49_1.time_ < var_52_0 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play123541013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 123541013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play123541014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1015ui_story"]) and arg_53_1.var_.characterEffect1015ui_story == nil then
				arg_53_1.var_.characterEffect1015ui_story = arg_53_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1015ui_story"]) then
				if arg_53_1.var_.characterEffect1015ui_story and not isNil(arg_53_1.actors_["1015ui_story"]) then
					arg_53_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1015ui_story"]) and arg_53_1.var_.characterEffect1015ui_story then
				arg_53_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 0.4

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(123541013).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 16 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 16)

				if (16 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 16)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play123541014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 123541014
		arg_57_1.duration_ = 2.67

		local var_57_0 = {
			zh = 2.2,
			ja = 2.666
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play123541015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1093ui_story = arg_57_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1093ui_story"].transform.position).z)
				arg_57_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1093ui_story"].transform.localEulerAngles = arg_57_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_57_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1093ui_story"].transform.position).z)
				arg_57_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1093ui_story"].transform.localEulerAngles = arg_57_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1093ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1093ui_story == nil then
				arg_57_1.var_.characterEffect1093ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1093ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1093ui_story then
				arg_57_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action469")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.175

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(123541014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 7 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 7)

				if (7 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 7)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541014", "story_v_out_123541.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_123541", "123541014", "story_v_out_123541.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_123541", "123541014", "story_v_out_123541.awb")

						arg_57_1:RecordAudio("123541014", var_60_11)
						arg_57_1:RecordAudio("123541014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_123541", "123541014", "story_v_out_123541.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_123541", "123541014", "story_v_out_123541.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play123541015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 123541015
		arg_61_1.duration_ = 2.97

		local var_61_0 = {
			zh = 2.3,
			ja = 2.966
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play123541016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1015ui_story"]) and arg_61_1.var_.characterEffect1015ui_story == nil then
				arg_61_1.var_.characterEffect1015ui_story = arg_61_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1015ui_story"]) then
				if arg_61_1.var_.characterEffect1015ui_story and not isNil(arg_61_1.actors_["1015ui_story"]) then
					arg_61_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1015ui_story"]) and arg_61_1.var_.characterEffect1015ui_story then
				arg_61_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_2 = arg_61_1.actors_["1093ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1093ui_story == nil then
				arg_61_1.var_.characterEffect1093ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect1093ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1093ui_story then
				arg_61_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_64_4 = 0
			local var_64_5 = 0.125

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(123541015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 5 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 5)

				if (5 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 5)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541015", "story_v_out_123541.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_123541", "123541015", "story_v_out_123541.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_123541", "123541015", "story_v_out_123541.awb")

						arg_61_1:RecordAudio("123541015", var_64_11)
						arg_61_1:RecordAudio("123541015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_123541", "123541015", "story_v_out_123541.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_123541", "123541015", "story_v_out_123541.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play123541016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 123541016
		arg_65_1.duration_ = 4.83

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play123541017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1015ui_story"]) and arg_65_1.var_.characterEffect1015ui_story == nil then
				arg_65_1.var_.characterEffect1015ui_story = arg_65_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1015ui_story"]) then
				if arg_65_1.var_.characterEffect1015ui_story and not isNil(arg_65_1.actors_["1015ui_story"]) then
					arg_65_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1015ui_story"]) and arg_65_1.var_.characterEffect1015ui_story then
				arg_65_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action496")
			end

			local var_68_1 = arg_65_1.actors_["1093ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1093ui_story == nil then
				arg_65_1.var_.characterEffect1093ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1093ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1093ui_story then
				arg_65_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.475

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(123541016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 19 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 19)

				if (19 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 19)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541016", "story_v_out_123541.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_123541", "123541016", "story_v_out_123541.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_123541", "123541016", "story_v_out_123541.awb")

						arg_65_1:RecordAudio("123541016", var_68_11)
						arg_65_1:RecordAudio("123541016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_123541", "123541016", "story_v_out_123541.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_123541", "123541016", "story_v_out_123541.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play123541017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 123541017
		arg_69_1.duration_ = 3.2

		local var_69_0 = {
			zh = 3.2,
			ja = 3.1
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play123541018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.35

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(123541017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 14 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 14)

				if (14 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 14)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541017", "story_v_out_123541.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541017", "story_v_out_123541.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_123541", "123541017", "story_v_out_123541.awb")

						arg_69_1:RecordAudio("123541017", var_72_6)
						arg_69_1:RecordAudio("123541017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_123541", "123541017", "story_v_out_123541.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_123541", "123541017", "story_v_out_123541.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play123541018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 123541018
		arg_73_1.duration_ = 2.4

		local var_73_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play123541019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1015ui_story"]) and arg_73_1.var_.characterEffect1015ui_story == nil then
				arg_73_1.var_.characterEffect1015ui_story = arg_73_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1015ui_story"]) then
				if arg_73_1.var_.characterEffect1015ui_story and not isNil(arg_73_1.actors_["1015ui_story"]) then
					arg_73_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1015ui_story"]) and arg_73_1.var_.characterEffect1015ui_story then
				arg_73_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_76_2 = arg_73_1.actors_["1093ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1093ui_story == nil then
				arg_73_1.var_.characterEffect1093ui_story = var_76_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_3 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.characterEffect1093ui_story and not isNil(var_76_2) then
					arg_73_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_3)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1093ui_story then
				arg_73_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_76_4 = 0
			local var_76_5 = 0.05

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(123541018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 2 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 2)

				if (2 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 2)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541018", "story_v_out_123541.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_123541", "123541018", "story_v_out_123541.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_123541", "123541018", "story_v_out_123541.awb")

						arg_73_1:RecordAudio("123541018", var_76_11)
						arg_73_1:RecordAudio("123541018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_123541", "123541018", "story_v_out_123541.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_123541", "123541018", "story_v_out_123541.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play123541019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 123541019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play123541020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1015ui_story"]) and arg_77_1.var_.characterEffect1015ui_story == nil then
				arg_77_1.var_.characterEffect1015ui_story = arg_77_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1015ui_story"]) then
				if arg_77_1.var_.characterEffect1015ui_story and not isNil(arg_77_1.actors_["1015ui_story"]) then
					arg_77_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1015ui_story"]) and arg_77_1.var_.characterEffect1015ui_story then
				arg_77_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.4

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(123541019).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 16 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 16)

				if (16 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 16)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play123541020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 123541020
		arg_81_1.duration_ = 12.8

		local var_81_0 = {
			zh = 12.266,
			ja = 12.8
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play123541021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1093ui_story"]) and arg_81_1.var_.characterEffect1093ui_story == nil then
				arg_81_1.var_.characterEffect1093ui_story = arg_81_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1093ui_story"]) then
				if arg_81_1.var_.characterEffect1093ui_story and not isNil(arg_81_1.actors_["1093ui_story"]) then
					arg_81_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1093ui_story"]) and arg_81_1.var_.characterEffect1093ui_story then
				arg_81_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_2 = 0
			local var_84_3 = 1.475

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(123541020)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 59 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 59)

				if (59 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 59)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541020", "story_v_out_123541.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_123541", "123541020", "story_v_out_123541.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_123541", "123541020", "story_v_out_123541.awb")

						arg_81_1:RecordAudio("123541020", var_84_9)
						arg_81_1:RecordAudio("123541020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_123541", "123541020", "story_v_out_123541.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_123541", "123541020", "story_v_out_123541.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_10 and arg_81_1.time_ < var_84_2 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play123541021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 123541021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play123541022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1093ui_story"]) and arg_85_1.var_.characterEffect1093ui_story == nil then
				arg_85_1.var_.characterEffect1093ui_story = arg_85_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1093ui_story"]) then
				if arg_85_1.var_.characterEffect1093ui_story and not isNil(arg_85_1.actors_["1093ui_story"]) then
					arg_85_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1093ui_story"]) and arg_85_1.var_.characterEffect1093ui_story then
				arg_85_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.45

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(123541021).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 18 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 18)

				if (18 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 18)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play123541022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 123541022
		arg_89_1.duration_ = 10.6

		local var_89_0 = {
			zh = 7.766,
			ja = 10.6
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play123541023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1015ui_story"]) and arg_89_1.var_.characterEffect1015ui_story == nil then
				arg_89_1.var_.characterEffect1015ui_story = arg_89_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1015ui_story"]) then
				if arg_89_1.var_.characterEffect1015ui_story and not isNil(arg_89_1.actors_["1015ui_story"]) then
					arg_89_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1015ui_story"]) and arg_89_1.var_.characterEffect1015ui_story then
				arg_89_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_2 = 0
			local var_92_3 = 0.9

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_4 = arg_89_1:GetWordFromCfg(123541022)
				local var_92_5 = arg_89_1:FormatText(var_92_4.content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 36 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 36)

				if (36 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 36)) > 0 and var_92_3 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_2
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541022", "story_v_out_123541.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_123541", "123541022", "story_v_out_123541.awb") / 1000

					if var_92_8 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_2
					end

					if var_92_4.prefab_name ~= "" and arg_89_1.actors_[var_92_4.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_4.prefab_name].transform, "story_v_out_123541", "123541022", "story_v_out_123541.awb")

						arg_89_1:RecordAudio("123541022", var_92_9)
						arg_89_1:RecordAudio("123541022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_123541", "123541022", "story_v_out_123541.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_123541", "123541022", "story_v_out_123541.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_3, arg_89_1.talkMaxDuration)

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_2) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_2 + var_92_10 and arg_89_1.time_ < var_92_2 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play123541023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 123541023
		arg_93_1.duration_ = 9.93

		local var_93_0 = {
			zh = 4.066,
			ja = 9.933
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play123541024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.4

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(123541023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 16 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 16)

				if (16 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 16)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541023", "story_v_out_123541.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541023", "story_v_out_123541.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_123541", "123541023", "story_v_out_123541.awb")

						arg_93_1:RecordAudio("123541023", var_96_6)
						arg_93_1:RecordAudio("123541023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_123541", "123541023", "story_v_out_123541.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_123541", "123541023", "story_v_out_123541.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play123541024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 123541024
		arg_97_1.duration_ = 2.27

		local var_97_0 = {
			zh = 1.999999999999,
			ja = 2.266
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play123541025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1093ui_story"]) and arg_97_1.var_.characterEffect1093ui_story == nil then
				arg_97_1.var_.characterEffect1093ui_story = arg_97_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1093ui_story"]) then
				if arg_97_1.var_.characterEffect1093ui_story and not isNil(arg_97_1.actors_["1093ui_story"]) then
					arg_97_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1093ui_story"]) and arg_97_1.var_.characterEffect1093ui_story then
				arg_97_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_2 = arg_97_1.actors_["1015ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.characterEffect1015ui_story == nil then
				arg_97_1.var_.characterEffect1015ui_story = var_100_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_3 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.characterEffect1015ui_story and not isNil(var_100_2) then
					arg_97_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_3)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.characterEffect1015ui_story then
				arg_97_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_100_4 = arg_97_1.actors_["1015ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1015ui_story = var_100_4.localPosition
			end

			local var_100_5 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 then
				var_100_4.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_5)
				var_100_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_4.position).x, (manager.ui.mainCamera.transform.position - var_100_4.position).y, (manager.ui.mainCamera.transform.position - var_100_4.position).z)
				var_100_4.localEulerAngles.z = 0
				var_100_4.localEulerAngles.x = 0
				var_100_4.localEulerAngles = var_100_4.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 then
				var_100_4.localPosition = Vector3.New(0, 100, 0)
				var_100_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_4.position).x, (manager.ui.mainCamera.transform.position - var_100_4.position).y, (manager.ui.mainCamera.transform.position - var_100_4.position).z)
				var_100_4.localEulerAngles.z = 0
				var_100_4.localEulerAngles.x = 0
				var_100_4.localEulerAngles = var_100_4.localEulerAngles
			end

			local var_100_6 = arg_97_1.actors_["1093ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1093ui_story = var_100_6.localPosition
			end

			local var_100_7 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				var_100_6.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_97_1.time_ - 0) / var_100_7)
				var_100_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_6.position).x, (manager.ui.mainCamera.transform.position - var_100_6.position).y, (manager.ui.mainCamera.transform.position - var_100_6.position).z)
				var_100_6.localEulerAngles.z = 0
				var_100_6.localEulerAngles.x = 0
				var_100_6.localEulerAngles = var_100_6.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				var_100_6.localPosition = Vector3.New(0, -1.11, -5.88)
				var_100_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_6.position).x, (manager.ui.mainCamera.transform.position - var_100_6.position).y, (manager.ui.mainCamera.transform.position - var_100_6.position).z)
				var_100_6.localEulerAngles.z = 0
				var_100_6.localEulerAngles.x = 0
				var_100_6.localEulerAngles = var_100_6.localEulerAngles
			end

			local var_100_8 = 0
			local var_100_9 = 0.125

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(123541024)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 5 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 5)

				if (5 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 5)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541024", "story_v_out_123541.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_123541", "123541024", "story_v_out_123541.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_out_123541", "123541024", "story_v_out_123541.awb")

						arg_97_1:RecordAudio("123541024", var_100_15)
						arg_97_1:RecordAudio("123541024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_123541", "123541024", "story_v_out_123541.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_123541", "123541024", "story_v_out_123541.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_16 and arg_97_1.time_ < var_100_8 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play123541025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 123541025
		arg_101_1.duration_ = 2

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play123541026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_104_0 = 0
			local var_104_1 = 0.05

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(123541025)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 2 <= 0 and var_104_1 or var_104_1 * (utf8.len(var_104_3) / 2)

				if (2 <= 0 and var_104_1 or var_104_1 * (utf8.len(var_104_3) / 2)) > 0 and var_104_1 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541025", "story_v_out_123541.awb") ~= 0 then
					local var_104_6 = manager.audio:GetVoiceLength("story_v_out_123541", "123541025", "story_v_out_123541.awb") / 1000

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end

					if var_104_2.prefab_name ~= "" and arg_101_1.actors_[var_104_2.prefab_name] ~= nil then
						local var_104_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_2.prefab_name].transform, "story_v_out_123541", "123541025", "story_v_out_123541.awb")

						arg_101_1:RecordAudio("123541025", var_104_7)
						arg_101_1:RecordAudio("123541025", var_104_7)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_123541", "123541025", "story_v_out_123541.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_123541", "123541025", "story_v_out_123541.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_8 and arg_101_1.time_ < var_104_0 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play123541026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 123541026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play123541027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1093ui_story"]) and arg_105_1.var_.characterEffect1093ui_story == nil then
				arg_105_1.var_.characterEffect1093ui_story = arg_105_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1093ui_story"]) then
				if arg_105_1.var_.characterEffect1093ui_story and not isNil(arg_105_1.actors_["1093ui_story"]) then
					arg_105_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1093ui_story"]) and arg_105_1.var_.characterEffect1093ui_story then
				arg_105_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.6

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(123541026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 24 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 24)

				if (24 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 24)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play123541027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 123541027
		arg_109_1.duration_ = 7.9

		local var_109_0 = {
			zh = 7.9,
			ja = 7
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play123541028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1093ui_story"]) and arg_109_1.var_.characterEffect1093ui_story == nil then
				arg_109_1.var_.characterEffect1093ui_story = arg_109_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1093ui_story"]) then
				if arg_109_1.var_.characterEffect1093ui_story and not isNil(arg_109_1.actors_["1093ui_story"]) then
					arg_109_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1093ui_story"]) and arg_109_1.var_.characterEffect1093ui_story then
				arg_109_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_2 = 0
			local var_112_3 = 0.9

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(123541027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 36 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 36)

				if (36 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 36)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541027", "story_v_out_123541.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_123541", "123541027", "story_v_out_123541.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_123541", "123541027", "story_v_out_123541.awb")

						arg_109_1:RecordAudio("123541027", var_112_9)
						arg_109_1:RecordAudio("123541027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_123541", "123541027", "story_v_out_123541.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_123541", "123541027", "story_v_out_123541.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play123541028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 123541028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play123541029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1093ui_story"]) and arg_113_1.var_.characterEffect1093ui_story == nil then
				arg_113_1.var_.characterEffect1093ui_story = arg_113_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1093ui_story"]) then
				if arg_113_1.var_.characterEffect1093ui_story and not isNil(arg_113_1.actors_["1093ui_story"]) then
					arg_113_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1093ui_story"]) and arg_113_1.var_.characterEffect1093ui_story then
				arg_113_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.675

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(123541028).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 27 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 27)

				if (27 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 27)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play123541029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 123541029
		arg_117_1.duration_ = 14

		local var_117_0 = {
			zh = 4.6,
			ja = 14
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play123541030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1015ui_story = arg_117_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1015ui_story"].transform.position).z)
				arg_117_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1015ui_story"].transform.localEulerAngles = arg_117_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0.7, -1.15, -6.2)
				arg_117_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1015ui_story"].transform.position).z)
				arg_117_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1015ui_story"].transform.localEulerAngles = arg_117_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1015ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1015ui_story == nil then
				arg_117_1.var_.characterEffect1015ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1015ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1015ui_story then
				arg_117_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_4 = arg_117_1.actors_["1093ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1093ui_story = var_120_4.localPosition
			end

			local var_120_5 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 then
				var_120_4.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_117_1.time_ - 0) / var_120_5)
				var_120_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_4.position).x, (manager.ui.mainCamera.transform.position - var_120_4.position).y, (manager.ui.mainCamera.transform.position - var_120_4.position).z)
				var_120_4.localEulerAngles.z = 0
				var_120_4.localEulerAngles.x = 0
				var_120_4.localEulerAngles = var_120_4.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 then
				var_120_4.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_120_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_4.position).x, (manager.ui.mainCamera.transform.position - var_120_4.position).y, (manager.ui.mainCamera.transform.position - var_120_4.position).z)
				var_120_4.localEulerAngles.z = 0
				var_120_4.localEulerAngles.x = 0
				var_120_4.localEulerAngles = var_120_4.localEulerAngles
			end

			local var_120_6 = 0
			local var_120_7 = 0.55

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(123541029)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 22 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 22)

				if (22 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 22)) > 0 and var_120_7 < var_120_11 then
					arg_117_1.talkMaxDuration = var_120_11

					if var_120_11 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541029", "story_v_out_123541.awb") ~= 0 then
					local var_120_12 = manager.audio:GetVoiceLength("story_v_out_123541", "123541029", "story_v_out_123541.awb") / 1000

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end

					if var_120_8.prefab_name ~= "" and arg_117_1.actors_[var_120_8.prefab_name] ~= nil then
						local var_120_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_8.prefab_name].transform, "story_v_out_123541", "123541029", "story_v_out_123541.awb")

						arg_117_1:RecordAudio("123541029", var_120_13)
						arg_117_1:RecordAudio("123541029", var_120_13)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_123541", "123541029", "story_v_out_123541.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_123541", "123541029", "story_v_out_123541.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play123541030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 123541030
		arg_121_1.duration_ = 4.03

		local var_121_0 = {
			zh = 3.866,
			ja = 4.033
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play123541031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1093ui_story"]) and arg_121_1.var_.characterEffect1093ui_story == nil then
				arg_121_1.var_.characterEffect1093ui_story = arg_121_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1093ui_story"]) then
				if arg_121_1.var_.characterEffect1093ui_story and not isNil(arg_121_1.actors_["1093ui_story"]) then
					arg_121_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1093ui_story"]) and arg_121_1.var_.characterEffect1093ui_story then
				arg_121_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action3_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_124_2 = arg_121_1.actors_["1015ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1015ui_story == nil then
				arg_121_1.var_.characterEffect1015ui_story = var_124_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_3 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.characterEffect1015ui_story and not isNil(var_124_2) then
					arg_121_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_3)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1015ui_story then
				arg_121_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_124_4 = 0
			local var_124_5 = 0.45

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(123541030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 18 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 18)

				if (18 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 18)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541030", "story_v_out_123541.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_123541", "123541030", "story_v_out_123541.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_123541", "123541030", "story_v_out_123541.awb")

						arg_121_1:RecordAudio("123541030", var_124_11)
						arg_121_1:RecordAudio("123541030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_123541", "123541030", "story_v_out_123541.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_123541", "123541030", "story_v_out_123541.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play123541031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 123541031
		arg_125_1.duration_ = 7.8

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play123541032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_0 = 2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				local var_128_1 = Color.New(0, 0, 0)

				var_128_1.a = Mathf.Lerp(0, 1, (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.mask_.color = var_128_1
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				local var_128_2 = Color.New(0, 0, 0)

				var_128_2.a = 1
				arg_125_1.mask_.color = var_128_2
			end

			local var_128_3 = 2

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_3 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_4 = 2

			if var_128_3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_3 + var_128_4 then
				local var_128_5 = Color.New(0, 0, 0)

				var_128_5.a = Mathf.Lerp(1, 0, (arg_125_1.time_ - var_128_3) / var_128_4)
				arg_125_1.mask_.color = var_128_5
			end

			if arg_125_1.time_ >= var_128_3 + var_128_4 and arg_125_1.time_ < var_128_3 + var_128_4 + arg_128_0 then
				local var_128_6 = Color.New(0, 0, 0)

				arg_125_1.mask_.enabled = false
				var_128_6.a = 0
				arg_125_1.mask_.color = var_128_6
			end

			local var_128_7 = arg_125_1.actors_["1093ui_story"].transform

			if 1.96599999815226 < arg_125_1.time_ and arg_125_1.time_ <= 1.96599999815226 + arg_128_0 then
				arg_125_1.var_.moveOldPos1093ui_story = var_128_7.localPosition
			end

			local var_128_8 = 0.001

			if 1.96599999815226 <= arg_125_1.time_ and arg_125_1.time_ < 1.96599999815226 + var_128_8 then
				var_128_7.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 1.96599999815226) / var_128_8)
				var_128_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_7.position).x, (manager.ui.mainCamera.transform.position - var_128_7.position).y, (manager.ui.mainCamera.transform.position - var_128_7.position).z)
				var_128_7.localEulerAngles.z = 0
				var_128_7.localEulerAngles.x = 0
				var_128_7.localEulerAngles = var_128_7.localEulerAngles
			end

			if arg_125_1.time_ >= 1.96599999815226 + var_128_8 and arg_125_1.time_ < 1.96599999815226 + var_128_8 + arg_128_0 then
				var_128_7.localPosition = Vector3.New(0, 100, 0)
				var_128_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_7.position).x, (manager.ui.mainCamera.transform.position - var_128_7.position).y, (manager.ui.mainCamera.transform.position - var_128_7.position).z)
				var_128_7.localEulerAngles.z = 0
				var_128_7.localEulerAngles.x = 0
				var_128_7.localEulerAngles = var_128_7.localEulerAngles
			end

			local var_128_9 = arg_125_1.actors_["1093ui_story"]

			if 1.96599999815226 < arg_125_1.time_ and arg_125_1.time_ <= 1.96599999815226 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1093ui_story == nil then
				arg_125_1.var_.characterEffect1093ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_10 = 0.034000001847744

			if 1.96599999815226 <= arg_125_1.time_ and arg_125_1.time_ < 1.96599999815226 + var_128_10 and not isNil(var_128_9) then
				if arg_125_1.var_.characterEffect1093ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 1.96599999815226) / var_128_10)
				end
			end

			if arg_125_1.time_ >= 1.96599999815226 + var_128_10 and arg_125_1.time_ < 1.96599999815226 + var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1093ui_story then
				arg_125_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_128_11 = arg_125_1.actors_["1015ui_story"].transform

			if 1.96599999815226 < arg_125_1.time_ and arg_125_1.time_ <= 1.96599999815226 + arg_128_0 then
				arg_125_1.var_.moveOldPos1015ui_story = var_128_11.localPosition
			end

			local var_128_12 = 0.001

			if 1.96599999815226 <= arg_125_1.time_ and arg_125_1.time_ < 1.96599999815226 + var_128_12 then
				var_128_11.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 1.96599999815226) / var_128_12)
				var_128_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_11.position).x, (manager.ui.mainCamera.transform.position - var_128_11.position).y, (manager.ui.mainCamera.transform.position - var_128_11.position).z)
				var_128_11.localEulerAngles.z = 0
				var_128_11.localEulerAngles.x = 0
				var_128_11.localEulerAngles = var_128_11.localEulerAngles
			end

			if arg_125_1.time_ >= 1.96599999815226 + var_128_12 and arg_125_1.time_ < 1.96599999815226 + var_128_12 + arg_128_0 then
				var_128_11.localPosition = Vector3.New(0, 100, 0)
				var_128_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_11.position).x, (manager.ui.mainCamera.transform.position - var_128_11.position).y, (manager.ui.mainCamera.transform.position - var_128_11.position).z)
				var_128_11.localEulerAngles.z = 0
				var_128_11.localEulerAngles.x = 0
				var_128_11.localEulerAngles = var_128_11.localEulerAngles
			end

			local var_128_13 = arg_125_1.actors_["1015ui_story"]

			if 1.96599999815226 < arg_125_1.time_ and arg_125_1.time_ <= 1.96599999815226 + arg_128_0 and not isNil(var_128_13) and arg_125_1.var_.characterEffect1015ui_story == nil then
				arg_125_1.var_.characterEffect1015ui_story = var_128_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_14 = 0.034000001847744

			if 1.96599999815226 <= arg_125_1.time_ and arg_125_1.time_ < 1.96599999815226 + var_128_14 and not isNil(var_128_13) then
				if arg_125_1.var_.characterEffect1015ui_story and not isNil(var_128_13) then
					arg_125_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 1.96599999815226) / var_128_14)
				end
			end

			if arg_125_1.time_ >= 1.96599999815226 + var_128_14 and arg_125_1.time_ < 1.96599999815226 + var_128_14 + arg_128_0 and not isNil(var_128_13) and arg_125_1.var_.characterEffect1015ui_story then
				arg_125_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if arg_125_1.frameCnt_ <= 1 then
				arg_125_1.dialog_:SetActive(false)
			end

			local var_128_15 = 2.8
			local var_128_16 = 0.325

			if 2.8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				arg_125_1.dialog_:SetActive(true)

				arg_125_1.dialogCg_.alpha = 0

				local var_128_17 = LeanTween.value(arg_125_1.dialog_, 0, 1, 0.3)

				var_128_17:setOnUpdate(LuaHelper.FloatAction(function(arg_129_0)
					arg_125_1.dialogCg_.alpha = arg_129_0
				end))
				var_128_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_125_1.dialog_)
					var_128_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_125_1.duration_ = arg_125_1.duration_ + 0.3

				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_18 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(123541031).content)

				arg_125_1.text_.text = var_128_18

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_20 = 13 <= 0 and var_128_16 or var_128_16 * (utf8.len(var_128_18) / 13)

				if (13 <= 0 and var_128_16 or var_128_16 * (utf8.len(var_128_18) / 13)) > 0 and var_128_16 < var_128_20 then
					arg_125_1.talkMaxDuration = var_128_20
					var_128_15 = var_128_15 + 0.3

					if var_128_20 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_20 + var_128_15
					end
				end

				arg_125_1.text_.text = var_128_18
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_21 = var_128_15 + 0.3
			local var_128_22 = math.max(var_128_16, arg_125_1.talkMaxDuration)

			if var_128_15 + 0.3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_21 + var_128_22 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_21) / var_128_22

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_21 + var_128_22 and arg_125_1.time_ < var_128_21 + var_128_22 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play123541032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 123541032
		arg_131_1.duration_ = 9

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play123541033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if arg_131_1.bgs_.ST12 == nil then
				local var_134_0 = Object.Instantiate(arg_131_1.paintGo_)

				var_134_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_134_0.name = "ST12"
				var_134_0.transform.parent = arg_131_1.stage_.transform
				var_134_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.bgs_.ST12 = var_134_0
			end

			if 2 < arg_131_1.time_ and arg_131_1.time_ <= 2 + arg_134_0 then
				local var_134_1 = arg_131_1.bgs_.ST12

				arg_131_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_134_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_134_2 = var_134_1:GetComponent("SpriteRenderer")

				if var_134_2 and var_134_2.sprite then
					local var_134_3 = 2 * (var_134_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_134_1.transform.localScale = Vector3.New(var_134_3 / var_134_2.sprite.bounds.size.y < var_134_3 * manager.ui.mainCameraCom_.aspect / var_134_2.sprite.bounds.size.x and var_134_3 * manager.ui.mainCameraCom_.aspect / var_134_2.sprite.bounds.size.x or var_134_3 / var_134_2.sprite.bounds.size.y, var_134_3 / var_134_2.sprite.bounds.size.y < var_134_3 * manager.ui.mainCameraCom_.aspect / var_134_2.sprite.bounds.size.x and var_134_3 * manager.ui.mainCameraCom_.aspect / var_134_2.sprite.bounds.size.x or var_134_3 / var_134_2.sprite.bounds.size.y, 0)
				end

				for iter_134_0, iter_134_1 in pairs(arg_131_1.bgs_) do
					if iter_134_0 ~= "ST12" then
						iter_134_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_134_4 = 0

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_5 = 2

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_5 then
				local var_134_6 = Color.New(0, 0, 0)

				var_134_6.a = Mathf.Lerp(0, 1, (arg_131_1.time_ - var_134_4) / var_134_5)
				arg_131_1.mask_.color = var_134_6
			end

			if arg_131_1.time_ >= var_134_4 + var_134_5 and arg_131_1.time_ < var_134_4 + var_134_5 + arg_134_0 then
				local var_134_7 = Color.New(0, 0, 0)

				var_134_7.a = 1
				arg_131_1.mask_.color = var_134_7
			end

			local var_134_8 = 2

			if 2 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_9 = 2

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_9 then
				local var_134_10 = Color.New(0, 0, 0)

				var_134_10.a = Mathf.Lerp(1, 0, (arg_131_1.time_ - var_134_8) / var_134_9)
				arg_131_1.mask_.color = var_134_10
			end

			if arg_131_1.time_ >= var_134_8 + var_134_9 and arg_131_1.time_ < var_134_8 + var_134_9 + arg_134_0 then
				local var_134_11 = Color.New(0, 0, 0)

				arg_131_1.mask_.enabled = false
				var_134_11.a = 0
				arg_131_1.mask_.color = var_134_11
			end

			if arg_131_1.frameCnt_ <= 1 then
				arg_131_1.dialog_:SetActive(false)
			end

			local var_134_12 = 4
			local var_134_13 = 0.5

			if 4 < arg_131_1.time_ and arg_131_1.time_ <= var_134_12 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				arg_131_1.dialog_:SetActive(true)

				arg_131_1.dialogCg_.alpha = 0

				local var_134_14 = LeanTween.value(arg_131_1.dialog_, 0, 1, 0.3)

				var_134_14:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_131_1.dialogCg_.alpha = arg_135_0
				end))
				var_134_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_131_1.dialog_)
					var_134_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_131_1.duration_ = arg_131_1.duration_ + 0.3

				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_15 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(123541032).content)

				arg_131_1.text_.text = var_134_15

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_17 = 20 <= 0 and var_134_13 or var_134_13 * (utf8.len(var_134_15) / 20)

				if (20 <= 0 and var_134_13 or var_134_13 * (utf8.len(var_134_15) / 20)) > 0 and var_134_13 < var_134_17 then
					arg_131_1.talkMaxDuration = var_134_17
					var_134_12 = var_134_12 + 0.3

					if var_134_17 + var_134_12 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_17 + var_134_12
					end
				end

				arg_131_1.text_.text = var_134_15
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_18 = var_134_12 + 0.3
			local var_134_19 = math.max(var_134_13, arg_131_1.talkMaxDuration)

			if var_134_12 + 0.3 <= arg_131_1.time_ and arg_131_1.time_ < var_134_18 + var_134_19 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_18) / var_134_19

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_18 + var_134_19 and arg_131_1.time_ < var_134_18 + var_134_19 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play123541033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 123541033
		arg_137_1.duration_ = 4.9

		local var_137_0 = {
			zh = 3,
			ja = 4.9
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play123541034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if arg_137_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_140_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_137_1.stage_.transform)

				var_140_0.name = "1019ui_story"
				var_140_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["1019ui_story"] = var_140_0

				local var_140_1 = var_140_0:GetComponentInChildren(typeof(CharacterEffect))

				var_140_1.enabled = true

				local var_140_2 = GameObjectTools.GetOrAddComponent(var_140_0, typeof(DynamicBoneHelper))

				if var_140_2 then
					var_140_2:EnableDynamicBone(false)
				end

				arg_137_1:ShowWeapon(var_140_1.transform, false)

				arg_137_1.var_["1019ui_story" .. "Animator"] = var_140_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_137_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_137_1.var_["1019ui_story" .. "LipSync"] = var_140_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_140_3 = arg_137_1.actors_["1019ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1019ui_story = var_140_3.localPosition
			end

			local var_140_4 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				var_140_3.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_137_1.time_ - 0) / var_140_4)
				var_140_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_3.position).x, (manager.ui.mainCamera.transform.position - var_140_3.position).y, (manager.ui.mainCamera.transform.position - var_140_3.position).z)
				var_140_3.localEulerAngles.z = 0
				var_140_3.localEulerAngles.x = 0
				var_140_3.localEulerAngles = var_140_3.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				var_140_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_140_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_3.position).x, (manager.ui.mainCamera.transform.position - var_140_3.position).y, (manager.ui.mainCamera.transform.position - var_140_3.position).z)
				var_140_3.localEulerAngles.z = 0
				var_140_3.localEulerAngles.x = 0
				var_140_3.localEulerAngles = var_140_3.localEulerAngles
			end

			local var_140_5 = arg_137_1.actors_["1019ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.characterEffect1019ui_story == nil then
				arg_137_1.var_.characterEffect1019ui_story = var_140_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_6 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_6 and not isNil(var_140_5) then
				if arg_137_1.var_.characterEffect1019ui_story and not isNil(var_140_5) then
					arg_137_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_6 and arg_137_1.time_ < 0 + var_140_6 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.characterEffect1019ui_story then
				arg_137_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_8 = 0
			local var_140_9 = 0.3

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_10 = arg_137_1:GetWordFromCfg(123541033)
				local var_140_11 = arg_137_1:FormatText(var_140_10.content)

				arg_137_1.text_.text = var_140_11

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 12 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 12)

				if (12 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 12)) > 0 and var_140_9 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_8
					end
				end

				arg_137_1.text_.text = var_140_11
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541033", "story_v_out_123541.awb") ~= 0 then
					local var_140_14 = manager.audio:GetVoiceLength("story_v_out_123541", "123541033", "story_v_out_123541.awb") / 1000

					if var_140_14 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_14 + var_140_8
					end

					if var_140_10.prefab_name ~= "" and arg_137_1.actors_[var_140_10.prefab_name] ~= nil then
						local var_140_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_10.prefab_name].transform, "story_v_out_123541", "123541033", "story_v_out_123541.awb")

						arg_137_1:RecordAudio("123541033", var_140_15)
						arg_137_1:RecordAudio("123541033", var_140_15)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_123541", "123541033", "story_v_out_123541.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_123541", "123541033", "story_v_out_123541.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_9, arg_137_1.talkMaxDuration)

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_8) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_8 + var_140_16 and arg_137_1.time_ < var_140_8 + var_140_16 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play123541034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 123541034
		arg_141_1.duration_ = 9.03

		local var_141_0 = {
			zh = 8.666,
			ja = 9.033
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
				arg_141_0:Play123541035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1093ui_story = arg_141_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).z)
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles = arg_141_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_141_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).z)
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles = arg_141_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1093ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1093ui_story == nil then
				arg_141_1.var_.characterEffect1093ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1093ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1093ui_story then
				arg_141_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_4 = arg_141_1.actors_["1019ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1019ui_story = var_144_4.localPosition
			end

			local var_144_5 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_5 then
				var_144_4.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_5)
				var_144_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_4.position).x, (manager.ui.mainCamera.transform.position - var_144_4.position).y, (manager.ui.mainCamera.transform.position - var_144_4.position).z)
				var_144_4.localEulerAngles.z = 0
				var_144_4.localEulerAngles.x = 0
				var_144_4.localEulerAngles = var_144_4.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_5 and arg_141_1.time_ < 0 + var_144_5 + arg_144_0 then
				var_144_4.localPosition = Vector3.New(0, 100, 0)
				var_144_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_4.position).x, (manager.ui.mainCamera.transform.position - var_144_4.position).y, (manager.ui.mainCamera.transform.position - var_144_4.position).z)
				var_144_4.localEulerAngles.z = 0
				var_144_4.localEulerAngles.x = 0
				var_144_4.localEulerAngles = var_144_4.localEulerAngles
			end

			local var_144_6 = arg_141_1.actors_["1019ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1019ui_story == nil then
				arg_141_1.var_.characterEffect1019ui_story = var_144_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_7 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 and not isNil(var_144_6) then
				if arg_141_1.var_.characterEffect1019ui_story and not isNil(var_144_6) then
					arg_141_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_7)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1019ui_story then
				arg_141_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				if arg_141_1.var_.characterEffect1093ui_story == nil then
					arg_141_1.var_.characterEffect1093ui_story = arg_141_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_144_8 = arg_141_1.var_.characterEffect1093ui_story

				arg_141_1.var_.characterEffect1093ui_story.imageEffect:turnOff()

				var_144_8.interferenceEffect.enabled = true
				var_144_8.interferenceEffect.noise = 0.001
				var_144_8.interferenceEffect.simTimeScale = 1
				var_144_8.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				if arg_141_1.var_.characterEffect1093ui_story == nil then
					arg_141_1.var_.characterEffect1093ui_story = arg_141_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_141_1.var_.characterEffect1093ui_story.imageEffect:turnOn(false)
			end

			local var_144_10 = 0
			local var_144_11 = 0.875

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_12 = arg_141_1:GetWordFromCfg(123541034)
				local var_144_13 = arg_141_1:FormatText(var_144_12.content)

				arg_141_1.text_.text = var_144_13

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_15 = 35 <= 0 and var_144_11 or var_144_11 * (utf8.len(var_144_13) / 35)

				if (35 <= 0 and var_144_11 or var_144_11 * (utf8.len(var_144_13) / 35)) > 0 and var_144_11 < var_144_15 then
					arg_141_1.talkMaxDuration = var_144_15

					if var_144_15 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_15 + var_144_10
					end
				end

				arg_141_1.text_.text = var_144_13
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541034", "story_v_out_123541.awb") ~= 0 then
					local var_144_16 = manager.audio:GetVoiceLength("story_v_out_123541", "123541034", "story_v_out_123541.awb") / 1000

					if var_144_16 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_16 + var_144_10
					end

					if var_144_12.prefab_name ~= "" and arg_141_1.actors_[var_144_12.prefab_name] ~= nil then
						local var_144_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_12.prefab_name].transform, "story_v_out_123541", "123541034", "story_v_out_123541.awb")

						arg_141_1:RecordAudio("123541034", var_144_17)
						arg_141_1:RecordAudio("123541034", var_144_17)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_123541", "123541034", "story_v_out_123541.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_123541", "123541034", "story_v_out_123541.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_18 = math.max(var_144_11, arg_141_1.talkMaxDuration)

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_18 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_10) / var_144_18

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_10 + var_144_18 and arg_141_1.time_ < var_144_10 + var_144_18 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play123541035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 123541035
		arg_145_1.duration_ = 14.97

		local var_145_0 = {
			zh = 14.966,
			ja = 11.966
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play123541036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1093ui_story = arg_145_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1093ui_story"].transform.position).z)
				arg_145_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1093ui_story"].transform.localEulerAngles = arg_145_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1093ui_story"].transform.position).z)
				arg_145_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1093ui_story"].transform.localEulerAngles = arg_145_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1093ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1093ui_story == nil then
				arg_145_1.var_.characterEffect1093ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1093ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_2)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1093ui_story then
				arg_145_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_148_3 = arg_145_1.actors_["1019ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1019ui_story = var_148_3.localPosition
			end

			local var_148_4 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				var_148_3.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_145_1.time_ - 0) / var_148_4)
				var_148_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_3.position).x, (manager.ui.mainCamera.transform.position - var_148_3.position).y, (manager.ui.mainCamera.transform.position - var_148_3.position).z)
				var_148_3.localEulerAngles.z = 0
				var_148_3.localEulerAngles.x = 0
				var_148_3.localEulerAngles = var_148_3.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				var_148_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_148_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_3.position).x, (manager.ui.mainCamera.transform.position - var_148_3.position).y, (manager.ui.mainCamera.transform.position - var_148_3.position).z)
				var_148_3.localEulerAngles.z = 0
				var_148_3.localEulerAngles.x = 0
				var_148_3.localEulerAngles = var_148_3.localEulerAngles
			end

			local var_148_5 = arg_145_1.actors_["1019ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.characterEffect1019ui_story == nil then
				arg_145_1.var_.characterEffect1019ui_story = var_148_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_6 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 and not isNil(var_148_5) then
				if arg_145_1.var_.characterEffect1019ui_story and not isNil(var_148_5) then
					arg_145_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.characterEffect1019ui_story then
				arg_145_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_8 = 0
			local var_148_9 = 1.575

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(123541035)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 63 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 63)

				if (63 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 63)) > 0 and var_148_9 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541035", "story_v_out_123541.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_123541", "123541035", "story_v_out_123541.awb") / 1000

					if var_148_14 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_8
					end

					if var_148_10.prefab_name ~= "" and arg_145_1.actors_[var_148_10.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_10.prefab_name].transform, "story_v_out_123541", "123541035", "story_v_out_123541.awb")

						arg_145_1:RecordAudio("123541035", var_148_15)
						arg_145_1:RecordAudio("123541035", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_123541", "123541035", "story_v_out_123541.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_123541", "123541035", "story_v_out_123541.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_16 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_16

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_16 and arg_145_1.time_ < var_148_8 + var_148_16 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play123541036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 123541036
		arg_149_1.duration_ = 10.7

		local var_149_0 = {
			zh = 8.5,
			ja = 10.7
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play123541037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 1.075

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:GetWordFromCfg(123541036)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 43 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 43)

				if (43 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 43)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541036", "story_v_out_123541.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541036", "story_v_out_123541.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_123541", "123541036", "story_v_out_123541.awb")

						arg_149_1:RecordAudio("123541036", var_152_6)
						arg_149_1:RecordAudio("123541036", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_123541", "123541036", "story_v_out_123541.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_123541", "123541036", "story_v_out_123541.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play123541037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 123541037
		arg_153_1.duration_ = 2

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play123541038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1093ui_story = arg_153_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1093ui_story"].transform.position).z)
				arg_153_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1093ui_story"].transform.localEulerAngles = arg_153_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_153_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1093ui_story"].transform.position).z)
				arg_153_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1093ui_story"].transform.localEulerAngles = arg_153_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1093ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1093ui_story == nil then
				arg_153_1.var_.characterEffect1093ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1093ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1093ui_story then
				arg_153_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_4 = arg_153_1.actors_["1019ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1019ui_story = var_156_4.localPosition
			end

			local var_156_5 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_5 then
				var_156_4.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_5)
				var_156_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_4.position).x, (manager.ui.mainCamera.transform.position - var_156_4.position).y, (manager.ui.mainCamera.transform.position - var_156_4.position).z)
				var_156_4.localEulerAngles.z = 0
				var_156_4.localEulerAngles.x = 0
				var_156_4.localEulerAngles = var_156_4.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_5 and arg_153_1.time_ < 0 + var_156_5 + arg_156_0 then
				var_156_4.localPosition = Vector3.New(0, 100, 0)
				var_156_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_4.position).x, (manager.ui.mainCamera.transform.position - var_156_4.position).y, (manager.ui.mainCamera.transform.position - var_156_4.position).z)
				var_156_4.localEulerAngles.z = 0
				var_156_4.localEulerAngles.x = 0
				var_156_4.localEulerAngles = var_156_4.localEulerAngles
			end

			local var_156_6 = arg_153_1.actors_["1019ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect1019ui_story == nil then
				arg_153_1.var_.characterEffect1019ui_story = var_156_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_7 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 and not isNil(var_156_6) then
				if arg_153_1.var_.characterEffect1019ui_story and not isNil(var_156_6) then
					arg_153_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_7)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect1019ui_story then
				arg_153_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_156_8 = 0
			local var_156_9 = 0.2

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_10 = arg_153_1:GetWordFromCfg(123541037)
				local var_156_11 = arg_153_1:FormatText(var_156_10.content)

				arg_153_1.text_.text = var_156_11

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_13 = 8 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 8)

				if (8 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 8)) > 0 and var_156_9 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_8
					end
				end

				arg_153_1.text_.text = var_156_11
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541037", "story_v_out_123541.awb") ~= 0 then
					local var_156_14 = manager.audio:GetVoiceLength("story_v_out_123541", "123541037", "story_v_out_123541.awb") / 1000

					if var_156_14 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_8
					end

					if var_156_10.prefab_name ~= "" and arg_153_1.actors_[var_156_10.prefab_name] ~= nil then
						local var_156_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_10.prefab_name].transform, "story_v_out_123541", "123541037", "story_v_out_123541.awb")

						arg_153_1:RecordAudio("123541037", var_156_15)
						arg_153_1:RecordAudio("123541037", var_156_15)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_123541", "123541037", "story_v_out_123541.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_123541", "123541037", "story_v_out_123541.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_16 = math.max(var_156_9, arg_153_1.talkMaxDuration)

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_16 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_8) / var_156_16

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_8 + var_156_16 and arg_153_1.time_ < var_156_8 + var_156_16 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play123541038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 123541038
		arg_157_1.duration_ = 10.2

		local var_157_0 = {
			zh = 10.2,
			ja = 9.2
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play123541039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1093ui_story = arg_157_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1093ui_story"].transform.position).z)
				arg_157_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1093ui_story"].transform.localEulerAngles = arg_157_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1093ui_story"].transform.position).z)
				arg_157_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1093ui_story"].transform.localEulerAngles = arg_157_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1093ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1093ui_story == nil then
				arg_157_1.var_.characterEffect1093ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1093ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_2)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1093ui_story then
				arg_157_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_160_3 = arg_157_1.actors_["1019ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1019ui_story = var_160_3.localPosition
			end

			local var_160_4 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				var_160_3.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_157_1.time_ - 0) / var_160_4)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				var_160_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles
			end

			local var_160_5 = arg_157_1.actors_["1019ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.characterEffect1019ui_story == nil then
				arg_157_1.var_.characterEffect1019ui_story = var_160_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_6 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_6 and not isNil(var_160_5) then
				if arg_157_1.var_.characterEffect1019ui_story and not isNil(var_160_5) then
					arg_157_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_6 and arg_157_1.time_ < 0 + var_160_6 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.characterEffect1019ui_story then
				arg_157_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_8 = 0
			local var_160_9 = 1.15

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(123541038)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 46 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 46)

				if (46 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 46)) > 0 and var_160_9 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541038", "story_v_out_123541.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_123541", "123541038", "story_v_out_123541.awb") / 1000

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end

					if var_160_10.prefab_name ~= "" and arg_157_1.actors_[var_160_10.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_10.prefab_name].transform, "story_v_out_123541", "123541038", "story_v_out_123541.awb")

						arg_157_1:RecordAudio("123541038", var_160_15)
						arg_157_1:RecordAudio("123541038", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_123541", "123541038", "story_v_out_123541.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_123541", "123541038", "story_v_out_123541.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play123541039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 123541039
		arg_161_1.duration_ = 3.87

		local var_161_0 = {
			zh = 3.866,
			ja = 2.1
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play123541040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1093ui_story = arg_161_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).z)
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles = arg_161_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_161_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1093ui_story"].transform.position).z)
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1093ui_story"].transform.localEulerAngles = arg_161_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1093ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1093ui_story == nil then
				arg_161_1.var_.characterEffect1093ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1093ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1093ui_story then
				arg_161_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_4 = arg_161_1.actors_["1019ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1019ui_story = var_164_4.localPosition
			end

			local var_164_5 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_5 then
				var_164_4.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_5)
				var_164_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_4.position).x, (manager.ui.mainCamera.transform.position - var_164_4.position).y, (manager.ui.mainCamera.transform.position - var_164_4.position).z)
				var_164_4.localEulerAngles.z = 0
				var_164_4.localEulerAngles.x = 0
				var_164_4.localEulerAngles = var_164_4.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_5 and arg_161_1.time_ < 0 + var_164_5 + arg_164_0 then
				var_164_4.localPosition = Vector3.New(0, 100, 0)
				var_164_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_4.position).x, (manager.ui.mainCamera.transform.position - var_164_4.position).y, (manager.ui.mainCamera.transform.position - var_164_4.position).z)
				var_164_4.localEulerAngles.z = 0
				var_164_4.localEulerAngles.x = 0
				var_164_4.localEulerAngles = var_164_4.localEulerAngles
			end

			local var_164_6 = arg_161_1.actors_["1019ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect1019ui_story == nil then
				arg_161_1.var_.characterEffect1019ui_story = var_164_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_7 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 and not isNil(var_164_6) then
				if arg_161_1.var_.characterEffect1019ui_story and not isNil(var_164_6) then
					arg_161_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_7)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect1019ui_story then
				arg_161_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_164_8 = 0
			local var_164_9 = 0.375

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_10 = arg_161_1:GetWordFromCfg(123541039)
				local var_164_11 = arg_161_1:FormatText(var_164_10.content)

				arg_161_1.text_.text = var_164_11

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 15 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 15)

				if (15 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 15)) > 0 and var_164_9 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_8
					end
				end

				arg_161_1.text_.text = var_164_11
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541039", "story_v_out_123541.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_123541", "123541039", "story_v_out_123541.awb") / 1000

					if var_164_14 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_8
					end

					if var_164_10.prefab_name ~= "" and arg_161_1.actors_[var_164_10.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_10.prefab_name].transform, "story_v_out_123541", "123541039", "story_v_out_123541.awb")

						arg_161_1:RecordAudio("123541039", var_164_15)
						arg_161_1:RecordAudio("123541039", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_123541", "123541039", "story_v_out_123541.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_123541", "123541039", "story_v_out_123541.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_9, arg_161_1.talkMaxDuration)

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_8) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_8 + var_164_16 and arg_161_1.time_ < var_164_8 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play123541040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 123541040
		arg_165_1.duration_ = 9

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play123541041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if arg_165_1.bgs_.ST06 == nil then
				local var_168_0 = Object.Instantiate(arg_165_1.paintGo_)

				var_168_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST06")
				var_168_0.name = "ST06"
				var_168_0.transform.parent = arg_165_1.stage_.transform
				var_168_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.bgs_.ST06 = var_168_0
			end

			if 2 < arg_165_1.time_ and arg_165_1.time_ <= 2 + arg_168_0 then
				local var_168_1 = arg_165_1.bgs_.ST06

				arg_165_1.bgs_.ST06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_168_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_168_2 = var_168_1:GetComponent("SpriteRenderer")

				if var_168_2 and var_168_2.sprite then
					local var_168_3 = 2 * (var_168_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_168_1.transform.localScale = Vector3.New(var_168_3 / var_168_2.sprite.bounds.size.y < var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x and var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x or var_168_3 / var_168_2.sprite.bounds.size.y, var_168_3 / var_168_2.sprite.bounds.size.y < var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x and var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x or var_168_3 / var_168_2.sprite.bounds.size.y, 0)
				end

				for iter_168_0, iter_168_1 in pairs(arg_165_1.bgs_) do
					if iter_168_0 ~= "ST06" then
						iter_168_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_168_4 = 0

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_5 = 2

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_5 then
				local var_168_6 = Color.New(0, 0, 0)

				var_168_6.a = Mathf.Lerp(0, 1, (arg_165_1.time_ - var_168_4) / var_168_5)
				arg_165_1.mask_.color = var_168_6
			end

			if arg_165_1.time_ >= var_168_4 + var_168_5 and arg_165_1.time_ < var_168_4 + var_168_5 + arg_168_0 then
				local var_168_7 = Color.New(0, 0, 0)

				var_168_7.a = 1
				arg_165_1.mask_.color = var_168_7
			end

			local var_168_8 = 2

			if 2 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_9 = 2

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_9 then
				local var_168_10 = Color.New(0, 0, 0)

				var_168_10.a = Mathf.Lerp(1, 0, (arg_165_1.time_ - var_168_8) / var_168_9)
				arg_165_1.mask_.color = var_168_10
			end

			if arg_165_1.time_ >= var_168_8 + var_168_9 and arg_165_1.time_ < var_168_8 + var_168_9 + arg_168_0 then
				local var_168_11 = Color.New(0, 0, 0)

				arg_165_1.mask_.enabled = false
				var_168_11.a = 0
				arg_165_1.mask_.color = var_168_11
			end

			local var_168_12 = arg_165_1.actors_["1093ui_story"].transform

			if 1.96599999815226 < arg_165_1.time_ and arg_165_1.time_ <= 1.96599999815226 + arg_168_0 then
				arg_165_1.var_.moveOldPos1093ui_story = var_168_12.localPosition
			end

			local var_168_13 = 0.001

			if 1.96599999815226 <= arg_165_1.time_ and arg_165_1.time_ < 1.96599999815226 + var_168_13 then
				var_168_12.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 1.96599999815226) / var_168_13)
				var_168_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_12.position).x, (manager.ui.mainCamera.transform.position - var_168_12.position).y, (manager.ui.mainCamera.transform.position - var_168_12.position).z)
				var_168_12.localEulerAngles.z = 0
				var_168_12.localEulerAngles.x = 0
				var_168_12.localEulerAngles = var_168_12.localEulerAngles
			end

			if arg_165_1.time_ >= 1.96599999815226 + var_168_13 and arg_165_1.time_ < 1.96599999815226 + var_168_13 + arg_168_0 then
				var_168_12.localPosition = Vector3.New(0, 100, 0)
				var_168_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_12.position).x, (manager.ui.mainCamera.transform.position - var_168_12.position).y, (manager.ui.mainCamera.transform.position - var_168_12.position).z)
				var_168_12.localEulerAngles.z = 0
				var_168_12.localEulerAngles.x = 0
				var_168_12.localEulerAngles = var_168_12.localEulerAngles
			end

			local var_168_14 = arg_165_1.actors_["1093ui_story"]

			if 1.96599999815226 < arg_165_1.time_ and arg_165_1.time_ <= 1.96599999815226 + arg_168_0 and not isNil(var_168_14) and arg_165_1.var_.characterEffect1093ui_story == nil then
				arg_165_1.var_.characterEffect1093ui_story = var_168_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_15 = 0.034000001847744

			if 1.96599999815226 <= arg_165_1.time_ and arg_165_1.time_ < 1.96599999815226 + var_168_15 and not isNil(var_168_14) then
				if arg_165_1.var_.characterEffect1093ui_story and not isNil(var_168_14) then
					arg_165_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 1.96599999815226) / var_168_15)
				end
			end

			if arg_165_1.time_ >= 1.96599999815226 + var_168_15 and arg_165_1.time_ < 1.96599999815226 + var_168_15 + arg_168_0 and not isNil(var_168_14) and arg_165_1.var_.characterEffect1093ui_story then
				arg_165_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_16 = 3.999999999999
			local var_168_17 = 0.95

			if 3.999999999999 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_18 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_18:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_19 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(123541040).content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_21 = 38 <= 0 and var_168_17 or var_168_17 * (utf8.len(var_168_19) / 38)

				if (38 <= 0 and var_168_17 or var_168_17 * (utf8.len(var_168_19) / 38)) > 0 and var_168_17 < var_168_21 then
					arg_165_1.talkMaxDuration = var_168_21
					var_168_16 = var_168_16 + 0.3

					if var_168_21 + var_168_16 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_21 + var_168_16
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_22 = var_168_16 + 0.3
			local var_168_23 = math.max(var_168_17, arg_165_1.talkMaxDuration)

			if var_168_16 + 0.3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_22 + var_168_23 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_22) / var_168_23

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_22 + var_168_23 and arg_165_1.time_ < var_168_22 + var_168_23 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play123541041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 123541041
		arg_171_1.duration_ = 9.43

		local var_171_0 = {
			zh = 8.233,
			ja = 9.433
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play123541042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if arg_171_1.actors_["10003ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10003ui_story"))) then
				local var_174_0 = Object.Instantiate(Asset.Load("Char/" .. "10003ui_story"), arg_171_1.stage_.transform)

				var_174_0.name = "10003ui_story"
				var_174_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.actors_["10003ui_story"] = var_174_0

				local var_174_1 = var_174_0:GetComponentInChildren(typeof(CharacterEffect))

				var_174_1.enabled = true

				local var_174_2 = GameObjectTools.GetOrAddComponent(var_174_0, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(false)
				end

				arg_171_1:ShowWeapon(var_174_1.transform, false)

				arg_171_1.var_["10003ui_story" .. "Animator"] = var_174_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_171_1.var_["10003ui_story" .. "Animator"].applyRootMotion = true
				arg_171_1.var_["10003ui_story" .. "LipSync"] = var_174_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_174_3 = arg_171_1.actors_["10003ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10003ui_story = var_174_3.localPosition
			end

			local var_174_4 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				var_174_3.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10003ui_story, Vector3.New(0, -1.05, -5.9), (arg_171_1.time_ - 0) / var_174_4)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				var_174_3.localPosition = Vector3.New(0, -1.05, -5.9)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			local var_174_5 = arg_171_1.actors_["10003ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.characterEffect10003ui_story == nil then
				arg_171_1.var_.characterEffect10003ui_story = var_174_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_6 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_6 and not isNil(var_174_5) then
				if arg_171_1.var_.characterEffect10003ui_story and not isNil(var_174_5) then
					arg_171_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_6 and arg_171_1.time_ < 0 + var_174_6 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.characterEffect10003ui_story then
				arg_171_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action1_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_174_8 = 0
			local var_174_9 = 0.6

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(123541041)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 24 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 24)

				if (24 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 24)) > 0 and var_174_9 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541041", "story_v_out_123541.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_123541", "123541041", "story_v_out_123541.awb") / 1000

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_123541", "123541041", "story_v_out_123541.awb")

						arg_171_1:RecordAudio("123541041", var_174_15)
						arg_171_1:RecordAudio("123541041", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_123541", "123541041", "story_v_out_123541.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_123541", "123541041", "story_v_out_123541.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_16 and arg_171_1.time_ < var_174_8 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play123541042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 123541042
		arg_175_1.duration_ = 8.87

		local var_175_0 = {
			zh = 5,
			ja = 8.866
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play123541043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.55

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(123541042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 22 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 22)

				if (22 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 22)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541042", "story_v_out_123541.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541042", "story_v_out_123541.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_123541", "123541042", "story_v_out_123541.awb")

						arg_175_1:RecordAudio("123541042", var_178_6)
						arg_175_1:RecordAudio("123541042", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_123541", "123541042", "story_v_out_123541.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_123541", "123541042", "story_v_out_123541.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play123541043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 123541043
		arg_179_1.duration_ = 5.97

		local var_179_0 = {
			zh = 4.433,
			ja = 5.966
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play123541044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action2_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_182_0 = 0
			local var_182_1 = 0.475

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(123541043)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 19 <= 0 and var_182_1 or var_182_1 * (utf8.len(var_182_3) / 19)

				if (19 <= 0 and var_182_1 or var_182_1 * (utf8.len(var_182_3) / 19)) > 0 and var_182_1 < var_182_5 then
					arg_179_1.talkMaxDuration = var_182_5

					if var_182_5 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541043", "story_v_out_123541.awb") ~= 0 then
					local var_182_6 = manager.audio:GetVoiceLength("story_v_out_123541", "123541043", "story_v_out_123541.awb") / 1000

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end

					if var_182_2.prefab_name ~= "" and arg_179_1.actors_[var_182_2.prefab_name] ~= nil then
						local var_182_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_2.prefab_name].transform, "story_v_out_123541", "123541043", "story_v_out_123541.awb")

						arg_179_1:RecordAudio("123541043", var_182_7)
						arg_179_1:RecordAudio("123541043", var_182_7)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_123541", "123541043", "story_v_out_123541.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_123541", "123541043", "story_v_out_123541.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_8 and arg_179_1.time_ < var_182_0 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play123541044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 123541044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play123541045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["10003ui_story"]) and arg_183_1.var_.characterEffect10003ui_story == nil then
				arg_183_1.var_.characterEffect10003ui_story = arg_183_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["10003ui_story"]) then
				if arg_183_1.var_.characterEffect10003ui_story and not isNil(arg_183_1.actors_["10003ui_story"]) then
					arg_183_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_183_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["10003ui_story"]) and arg_183_1.var_.characterEffect10003ui_story then
				arg_183_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_183_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			local var_186_1 = 0
			local var_186_2 = 0.425

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(123541044).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 17 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 17)

				if (17 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 17)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play123541045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 123541045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play123541046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 1.15

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(123541045).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 46 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 46)

				if (46 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 46)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play123541046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 123541046
		arg_191_1.duration_ = 2.9

		local var_191_0 = {
			zh = 1.999999999999,
			ja = 2.9
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play123541047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["10003ui_story"]) and arg_191_1.var_.characterEffect10003ui_story == nil then
				arg_191_1.var_.characterEffect10003ui_story = arg_191_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["10003ui_story"]) then
				if arg_191_1.var_.characterEffect10003ui_story and not isNil(arg_191_1.actors_["10003ui_story"]) then
					arg_191_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["10003ui_story"]) and arg_191_1.var_.characterEffect10003ui_story then
				arg_191_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_194_2 = 0
			local var_194_3 = 0.175

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(123541046)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 7 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 7)

				if (7 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 7)) > 0 and var_194_3 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_2
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541046", "story_v_out_123541.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_123541", "123541046", "story_v_out_123541.awb") / 1000

					if var_194_8 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_2
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_out_123541", "123541046", "story_v_out_123541.awb")

						arg_191_1:RecordAudio("123541046", var_194_9)
						arg_191_1:RecordAudio("123541046", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_123541", "123541046", "story_v_out_123541.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_123541", "123541046", "story_v_out_123541.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_3, arg_191_1.talkMaxDuration)

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_2) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_2 + var_194_10 and arg_191_1.time_ < var_194_2 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play123541047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 123541047
		arg_195_1.duration_ = 18.3

		local var_195_0 = {
			zh = 16.5,
			ja = 18.3
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play123541048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 1.8

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(123541047)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 72 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 72)

				if (72 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 72)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541047", "story_v_out_123541.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541047", "story_v_out_123541.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_123541", "123541047", "story_v_out_123541.awb")

						arg_195_1:RecordAudio("123541047", var_198_6)
						arg_195_1:RecordAudio("123541047", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_123541", "123541047", "story_v_out_123541.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_123541", "123541047", "story_v_out_123541.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play123541048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 123541048
		arg_199_1.duration_ = 11.67

		local var_199_0 = {
			zh = 10,
			ja = 11.666
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play123541049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 1.15

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:GetWordFromCfg(123541048)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 46 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 46)

				if (46 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 46)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541048", "story_v_out_123541.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541048", "story_v_out_123541.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_123541", "123541048", "story_v_out_123541.awb")

						arg_199_1:RecordAudio("123541048", var_202_6)
						arg_199_1:RecordAudio("123541048", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_123541", "123541048", "story_v_out_123541.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_123541", "123541048", "story_v_out_123541.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play123541049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 123541049
		arg_203_1.duration_ = 12.3

		local var_203_0 = {
			zh = 10.566,
			ja = 12.3
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play123541050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003actionlink/10003action425")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_206_0 = 0
			local var_206_1 = 0.9

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_2 = arg_203_1:GetWordFromCfg(123541049)
				local var_206_3 = arg_203_1:FormatText(var_206_2.content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 36 <= 0 and var_206_1 or var_206_1 * (utf8.len(var_206_3) / 36)

				if (36 <= 0 and var_206_1 or var_206_1 * (utf8.len(var_206_3) / 36)) > 0 and var_206_1 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541049", "story_v_out_123541.awb") ~= 0 then
					local var_206_6 = manager.audio:GetVoiceLength("story_v_out_123541", "123541049", "story_v_out_123541.awb") / 1000

					if var_206_6 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_0
					end

					if var_206_2.prefab_name ~= "" and arg_203_1.actors_[var_206_2.prefab_name] ~= nil then
						local var_206_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_2.prefab_name].transform, "story_v_out_123541", "123541049", "story_v_out_123541.awb")

						arg_203_1:RecordAudio("123541049", var_206_7)
						arg_203_1:RecordAudio("123541049", var_206_7)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_123541", "123541049", "story_v_out_123541.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_123541", "123541049", "story_v_out_123541.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_8 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_8 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_8

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_8 and arg_203_1.time_ < var_206_0 + var_206_8 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play123541050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 123541050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play123541051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["10003ui_story"]) and arg_207_1.var_.characterEffect10003ui_story == nil then
				arg_207_1.var_.characterEffect10003ui_story = arg_207_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["10003ui_story"]) then
				if arg_207_1.var_.characterEffect10003ui_story and not isNil(arg_207_1.actors_["10003ui_story"]) then
					arg_207_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["10003ui_story"]) and arg_207_1.var_.characterEffect10003ui_story then
				arg_207_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 1

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(123541050).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 40 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 40)

				if (40 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 40)) > 0 and var_210_2 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_6 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_6 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_6

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_6 and arg_207_1.time_ < var_210_1 + var_210_6 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play123541051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 123541051
		arg_211_1.duration_ = 6

		local var_211_0 = {
			zh = 6,
			ja = 5.5
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play123541052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["10003ui_story"]) and arg_211_1.var_.characterEffect10003ui_story == nil then
				arg_211_1.var_.characterEffect10003ui_story = arg_211_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["10003ui_story"]) then
				if arg_211_1.var_.characterEffect10003ui_story and not isNil(arg_211_1.actors_["10003ui_story"]) then
					arg_211_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["10003ui_story"]) and arg_211_1.var_.characterEffect10003ui_story then
				arg_211_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action5_2")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_214_2 = 0
			local var_214_3 = 0.6

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_4 = arg_211_1:GetWordFromCfg(123541051)
				local var_214_5 = arg_211_1:FormatText(var_214_4.content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 24 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 24)

				if (24 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 24)) > 0 and var_214_3 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541051", "story_v_out_123541.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_123541", "123541051", "story_v_out_123541.awb") / 1000

					if var_214_8 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_2
					end

					if var_214_4.prefab_name ~= "" and arg_211_1.actors_[var_214_4.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_4.prefab_name].transform, "story_v_out_123541", "123541051", "story_v_out_123541.awb")

						arg_211_1:RecordAudio("123541051", var_214_9)
						arg_211_1:RecordAudio("123541051", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_123541", "123541051", "story_v_out_123541.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_123541", "123541051", "story_v_out_123541.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_3, arg_211_1.talkMaxDuration)

			if var_214_2 <= arg_211_1.time_ and arg_211_1.time_ < var_214_2 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_2) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_2 + var_214_10 and arg_211_1.time_ < var_214_2 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play123541052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 123541052
		arg_215_1.duration_ = 8.3

		local var_215_0 = {
			zh = 4.666,
			ja = 8.3
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play123541053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.525

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:GetWordFromCfg(123541052)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 21 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 21)

				if (21 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 21)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541052", "story_v_out_123541.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541052", "story_v_out_123541.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_123541", "123541052", "story_v_out_123541.awb")

						arg_215_1:RecordAudio("123541052", var_218_6)
						arg_215_1:RecordAudio("123541052", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_123541", "123541052", "story_v_out_123541.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_123541", "123541052", "story_v_out_123541.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play123541053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 123541053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play123541054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["10003ui_story"]) and arg_219_1.var_.characterEffect10003ui_story == nil then
				arg_219_1.var_.characterEffect10003ui_story = arg_219_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["10003ui_story"]) then
				if arg_219_1.var_.characterEffect10003ui_story and not isNil(arg_219_1.actors_["10003ui_story"]) then
					arg_219_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_219_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["10003ui_story"]) and arg_219_1.var_.characterEffect10003ui_story then
				arg_219_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_219_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 0.075

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(123541053).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 3 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 3)

				if (3 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 3)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_6 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_6 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_6

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_6 and arg_219_1.time_ < var_222_1 + var_222_6 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play123541054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 123541054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play123541055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.5

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(123541054).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 20 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 20)

				if (20 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 20)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play123541055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 123541055
		arg_227_1.duration_ = 13.9

		local var_227_0 = {
			zh = 12.6,
			ja = 13.9
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play123541056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["10003ui_story"]) and arg_227_1.var_.characterEffect10003ui_story == nil then
				arg_227_1.var_.characterEffect10003ui_story = arg_227_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["10003ui_story"]) then
				if arg_227_1.var_.characterEffect10003ui_story and not isNil(arg_227_1.actors_["10003ui_story"]) then
					arg_227_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["10003ui_story"]) and arg_227_1.var_.characterEffect10003ui_story then
				arg_227_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action1_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_2 = 0
			local var_230_3 = 1.25

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_4 = arg_227_1:GetWordFromCfg(123541055)
				local var_230_5 = arg_227_1:FormatText(var_230_4.content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 50 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 50)

				if (50 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 50)) > 0 and var_230_3 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541055", "story_v_out_123541.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_123541", "123541055", "story_v_out_123541.awb") / 1000

					if var_230_8 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_2
					end

					if var_230_4.prefab_name ~= "" and arg_227_1.actors_[var_230_4.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_4.prefab_name].transform, "story_v_out_123541", "123541055", "story_v_out_123541.awb")

						arg_227_1:RecordAudio("123541055", var_230_9)
						arg_227_1:RecordAudio("123541055", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_123541", "123541055", "story_v_out_123541.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_123541", "123541055", "story_v_out_123541.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_10 and arg_227_1.time_ < var_230_2 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play123541056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 123541056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play123541057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["10003ui_story"]) and arg_231_1.var_.characterEffect10003ui_story == nil then
				arg_231_1.var_.characterEffect10003ui_story = arg_231_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["10003ui_story"]) then
				if arg_231_1.var_.characterEffect10003ui_story and not isNil(arg_231_1.actors_["10003ui_story"]) then
					arg_231_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_231_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_0)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["10003ui_story"]) and arg_231_1.var_.characterEffect10003ui_story then
				arg_231_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_231_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			local var_234_1 = 0
			local var_234_2 = 0.075

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(123541056).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 3 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 3)

				if (3 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 3)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_6 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_6 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_6

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_6 and arg_231_1.time_ < var_234_1 + var_234_6 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play123541057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 123541057
		arg_235_1.duration_ = 9.07

		local var_235_0 = {
			zh = 6.633,
			ja = 9.066
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play123541058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["10003ui_story"]) and arg_235_1.var_.characterEffect10003ui_story == nil then
				arg_235_1.var_.characterEffect10003ui_story = arg_235_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["10003ui_story"]) then
				if arg_235_1.var_.characterEffect10003ui_story and not isNil(arg_235_1.actors_["10003ui_story"]) then
					arg_235_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["10003ui_story"]) and arg_235_1.var_.characterEffect10003ui_story then
				arg_235_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			local var_238_2 = 0
			local var_238_3 = 0.825

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_4 = arg_235_1:GetWordFromCfg(123541057)
				local var_238_5 = arg_235_1:FormatText(var_238_4.content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 33 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 33)

				if (33 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 33)) > 0 and var_238_3 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_2
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541057", "story_v_out_123541.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_123541", "123541057", "story_v_out_123541.awb") / 1000

					if var_238_8 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_2
					end

					if var_238_4.prefab_name ~= "" and arg_235_1.actors_[var_238_4.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_4.prefab_name].transform, "story_v_out_123541", "123541057", "story_v_out_123541.awb")

						arg_235_1:RecordAudio("123541057", var_238_9)
						arg_235_1:RecordAudio("123541057", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_123541", "123541057", "story_v_out_123541.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_123541", "123541057", "story_v_out_123541.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_3, arg_235_1.talkMaxDuration)

			if var_238_2 <= arg_235_1.time_ and arg_235_1.time_ < var_238_2 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_2) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_2 + var_238_10 and arg_235_1.time_ < var_238_2 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play123541058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 123541058
		arg_239_1.duration_ = 13.8

		local var_239_0 = {
			zh = 10.133,
			ja = 13.8
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play123541059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 1.075

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:GetWordFromCfg(123541058)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 43 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 43)

				if (43 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 43)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541058", "story_v_out_123541.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541058", "story_v_out_123541.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_123541", "123541058", "story_v_out_123541.awb")

						arg_239_1:RecordAudio("123541058", var_242_6)
						arg_239_1:RecordAudio("123541058", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_123541", "123541058", "story_v_out_123541.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_123541", "123541058", "story_v_out_123541.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play123541059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 123541059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play123541060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["10003ui_story"]) and arg_243_1.var_.characterEffect10003ui_story == nil then
				arg_243_1.var_.characterEffect10003ui_story = arg_243_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["10003ui_story"]) then
				if arg_243_1.var_.characterEffect10003ui_story and not isNil(arg_243_1.actors_["10003ui_story"]) then
					arg_243_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_243_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["10003ui_story"]) and arg_243_1.var_.characterEffect10003ui_story then
				arg_243_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_243_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 0.25

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(123541059).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 10 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 10)

				if (10 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 10)) > 0 and var_246_2 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_6 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_6 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_6

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_6 and arg_243_1.time_ < var_246_1 + var_246_6 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play123541060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 123541060
		arg_247_1.duration_ = 10.9

		local var_247_0 = {
			zh = 10.9,
			ja = 8.1
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play123541061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["10003ui_story"]) and arg_247_1.var_.characterEffect10003ui_story == nil then
				arg_247_1.var_.characterEffect10003ui_story = arg_247_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["10003ui_story"]) then
				if arg_247_1.var_.characterEffect10003ui_story and not isNil(arg_247_1.actors_["10003ui_story"]) then
					arg_247_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["10003ui_story"]) and arg_247_1.var_.characterEffect10003ui_story then
				arg_247_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action3_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_250_2 = 0
			local var_250_3 = 1.025

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(123541060)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 41 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 41)

				if (41 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 41)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541060", "story_v_out_123541.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_123541", "123541060", "story_v_out_123541.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_out_123541", "123541060", "story_v_out_123541.awb")

						arg_247_1:RecordAudio("123541060", var_250_9)
						arg_247_1:RecordAudio("123541060", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_123541", "123541060", "story_v_out_123541.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_123541", "123541060", "story_v_out_123541.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play123541061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 123541061
		arg_251_1.duration_ = 12.5

		local var_251_0 = {
			zh = 9.366,
			ja = 12.5
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
				arg_251_0:Play123541062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 1.05

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:GetWordFromCfg(123541061)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 42 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 42)

				if (42 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 42)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541061", "story_v_out_123541.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541061", "story_v_out_123541.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_123541", "123541061", "story_v_out_123541.awb")

						arg_251_1:RecordAudio("123541061", var_254_6)
						arg_251_1:RecordAudio("123541061", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_123541", "123541061", "story_v_out_123541.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_123541", "123541061", "story_v_out_123541.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play123541062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 123541062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play123541063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["10003ui_story"]) and arg_255_1.var_.characterEffect10003ui_story == nil then
				arg_255_1.var_.characterEffect10003ui_story = arg_255_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["10003ui_story"]) then
				if arg_255_1.var_.characterEffect10003ui_story and not isNil(arg_255_1.actors_["10003ui_story"]) then
					arg_255_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["10003ui_story"]) and arg_255_1.var_.characterEffect10003ui_story then
				arg_255_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			local var_258_1 = 0
			local var_258_2 = 0.1

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

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(123541062).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 4 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 4)

				if (4 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 4)) > 0 and var_258_2 < var_258_5 then
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
	Play123541063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 123541063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play123541064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.325

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(123541063).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 13 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 13)

				if (13 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 13)) > 0 and var_262_0 < var_262_3 then
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
	Play123541064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 123541064
		arg_263_1.duration_ = 12.1

		local var_263_0 = {
			zh = 5.666,
			ja = 12.1
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
				arg_263_0:Play123541065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["10003ui_story"]) and arg_263_1.var_.characterEffect10003ui_story == nil then
				arg_263_1.var_.characterEffect10003ui_story = arg_263_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["10003ui_story"]) then
				if arg_263_1.var_.characterEffect10003ui_story and not isNil(arg_263_1.actors_["10003ui_story"]) then
					arg_263_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["10003ui_story"]) and arg_263_1.var_.characterEffect10003ui_story then
				arg_263_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action3_2")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_266_2 = 0
			local var_266_3 = 0.525

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_2 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_4 = arg_263_1:GetWordFromCfg(123541064)
				local var_266_5 = arg_263_1:FormatText(var_266_4.content)

				arg_263_1.text_.text = var_266_5

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_7 = 21 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_5) / 21)

				if (21 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_5) / 21)) > 0 and var_266_3 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_2
					end
				end

				arg_263_1.text_.text = var_266_5
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541064", "story_v_out_123541.awb") ~= 0 then
					local var_266_8 = manager.audio:GetVoiceLength("story_v_out_123541", "123541064", "story_v_out_123541.awb") / 1000

					if var_266_8 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_2
					end

					if var_266_4.prefab_name ~= "" and arg_263_1.actors_[var_266_4.prefab_name] ~= nil then
						local var_266_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_4.prefab_name].transform, "story_v_out_123541", "123541064", "story_v_out_123541.awb")

						arg_263_1:RecordAudio("123541064", var_266_9)
						arg_263_1:RecordAudio("123541064", var_266_9)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_123541", "123541064", "story_v_out_123541.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_123541", "123541064", "story_v_out_123541.awb")
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
	Play123541065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 123541065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play123541066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["10003ui_story"]) and arg_267_1.var_.characterEffect10003ui_story == nil then
				arg_267_1.var_.characterEffect10003ui_story = arg_267_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["10003ui_story"]) then
				if arg_267_1.var_.characterEffect10003ui_story and not isNil(arg_267_1.actors_["10003ui_story"]) then
					arg_267_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_267_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_0)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["10003ui_story"]) and arg_267_1.var_.characterEffect10003ui_story then
				arg_267_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_267_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			local var_270_1 = 0
			local var_270_2 = 0.15

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

				local var_270_3 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(123541065).content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 6 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 6)

				if (6 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 6)) > 0 and var_270_2 < var_270_5 then
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
	Play123541066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 123541066
		arg_271_1.duration_ = 11.37

		local var_271_0 = {
			zh = 8.433,
			ja = 11.366
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
				arg_271_0:Play123541067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["10003ui_story"]) and arg_271_1.var_.characterEffect10003ui_story == nil then
				arg_271_1.var_.characterEffect10003ui_story = arg_271_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["10003ui_story"]) then
				if arg_271_1.var_.characterEffect10003ui_story and not isNil(arg_271_1.actors_["10003ui_story"]) then
					arg_271_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["10003ui_story"]) and arg_271_1.var_.characterEffect10003ui_story then
				arg_271_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			local var_274_2 = 0
			local var_274_3 = 0.8

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_4 = arg_271_1:GetWordFromCfg(123541066)
				local var_274_5 = arg_271_1:FormatText(var_274_4.content)

				arg_271_1.text_.text = var_274_5

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_7 = 32 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 32)

				if (32 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 32)) > 0 and var_274_3 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_2
					end
				end

				arg_271_1.text_.text = var_274_5
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541066", "story_v_out_123541.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_out_123541", "123541066", "story_v_out_123541.awb") / 1000

					if var_274_8 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_2
					end

					if var_274_4.prefab_name ~= "" and arg_271_1.actors_[var_274_4.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_4.prefab_name].transform, "story_v_out_123541", "123541066", "story_v_out_123541.awb")

						arg_271_1:RecordAudio("123541066", var_274_9)
						arg_271_1:RecordAudio("123541066", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_123541", "123541066", "story_v_out_123541.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_123541", "123541066", "story_v_out_123541.awb")
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
	Play123541067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 123541067
		arg_275_1.duration_ = 4.3

		local var_275_0 = {
			zh = 4.3,
			ja = 4
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play123541068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.4

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:GetWordFromCfg(123541067)
				local var_278_2 = arg_275_1:FormatText(var_278_1.content)

				arg_275_1.text_.text = var_278_2

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 16 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 16)

				if (16 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 16)) > 0 and var_278_0 < var_278_4 then
					arg_275_1.talkMaxDuration = var_278_4

					if var_278_4 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_4 + 0
					end
				end

				arg_275_1.text_.text = var_278_2
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541067", "story_v_out_123541.awb") ~= 0 then
					local var_278_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541067", "story_v_out_123541.awb") / 1000

					if var_278_5 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + 0
					end

					if var_278_1.prefab_name ~= "" and arg_275_1.actors_[var_278_1.prefab_name] ~= nil then
						local var_278_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_1.prefab_name].transform, "story_v_out_123541", "123541067", "story_v_out_123541.awb")

						arg_275_1:RecordAudio("123541067", var_278_6)
						arg_275_1:RecordAudio("123541067", var_278_6)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_123541", "123541067", "story_v_out_123541.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_123541", "123541067", "story_v_out_123541.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play123541068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 123541068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play123541069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["10003ui_story"]) and arg_279_1.var_.characterEffect10003ui_story == nil then
				arg_279_1.var_.characterEffect10003ui_story = arg_279_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["10003ui_story"]) then
				if arg_279_1.var_.characterEffect10003ui_story and not isNil(arg_279_1.actors_["10003ui_story"]) then
					arg_279_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_279_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["10003ui_story"]) and arg_279_1.var_.characterEffect10003ui_story then
				arg_279_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_279_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 0.625

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(123541068).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 25 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 25)

				if (25 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 25)) > 0 and var_282_2 < var_282_5 then
					arg_279_1.talkMaxDuration = var_282_5

					if var_282_5 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_6 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_6 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_6

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_6 and arg_279_1.time_ < var_282_1 + var_282_6 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play123541069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 123541069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play123541070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.5

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(123541069).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 20 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 20)

				if (20 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 20)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play123541070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 123541070
		arg_287_1.duration_ = 9

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play123541071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if arg_287_1.bgs_.K07g == nil then
				local var_290_0 = Object.Instantiate(arg_287_1.paintGo_)

				var_290_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K07g")
				var_290_0.name = "K07g"
				var_290_0.transform.parent = arg_287_1.stage_.transform
				var_290_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_287_1.bgs_.K07g = var_290_0
			end

			if 2 < arg_287_1.time_ and arg_287_1.time_ <= 2 + arg_290_0 then
				local var_290_1 = arg_287_1.bgs_.K07g

				arg_287_1.bgs_.K07g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_290_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_290_2 = var_290_1:GetComponent("SpriteRenderer")

				if var_290_2 and var_290_2.sprite then
					local var_290_3 = 2 * (var_290_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_290_1.transform.localScale = Vector3.New(var_290_3 / var_290_2.sprite.bounds.size.y < var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x and var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x or var_290_3 / var_290_2.sprite.bounds.size.y, var_290_3 / var_290_2.sprite.bounds.size.y < var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x and var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x or var_290_3 / var_290_2.sprite.bounds.size.y, 0)
				end

				for iter_290_0, iter_290_1 in pairs(arg_287_1.bgs_) do
					if iter_290_0 ~= "K07g" then
						iter_290_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_290_4 = 0

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_5 = 2

			if var_290_4 <= arg_287_1.time_ and arg_287_1.time_ < var_290_4 + var_290_5 then
				local var_290_6 = Color.New(0, 0, 0)

				var_290_6.a = Mathf.Lerp(0, 1, (arg_287_1.time_ - var_290_4) / var_290_5)
				arg_287_1.mask_.color = var_290_6
			end

			if arg_287_1.time_ >= var_290_4 + var_290_5 and arg_287_1.time_ < var_290_4 + var_290_5 + arg_290_0 then
				local var_290_7 = Color.New(0, 0, 0)

				var_290_7.a = 1
				arg_287_1.mask_.color = var_290_7
			end

			local var_290_8 = 2

			if 2 < arg_287_1.time_ and arg_287_1.time_ <= var_290_8 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_9 = 2

			if var_290_8 <= arg_287_1.time_ and arg_287_1.time_ < var_290_8 + var_290_9 then
				local var_290_10 = Color.New(0, 0, 0)

				var_290_10.a = Mathf.Lerp(1, 0, (arg_287_1.time_ - var_290_8) / var_290_9)
				arg_287_1.mask_.color = var_290_10
			end

			if arg_287_1.time_ >= var_290_8 + var_290_9 and arg_287_1.time_ < var_290_8 + var_290_9 + arg_290_0 then
				local var_290_11 = Color.New(0, 0, 0)

				arg_287_1.mask_.enabled = false
				var_290_11.a = 0
				arg_287_1.mask_.color = var_290_11
			end

			local var_290_12 = arg_287_1.actors_["10003ui_story"]

			if 1.96599999815226 < arg_287_1.time_ and arg_287_1.time_ <= 1.96599999815226 + arg_290_0 and not isNil(var_290_12) and arg_287_1.var_.characterEffect10003ui_story == nil then
				arg_287_1.var_.characterEffect10003ui_story = var_290_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_13 = 0.034000001847744

			if 1.96599999815226 <= arg_287_1.time_ and arg_287_1.time_ < 1.96599999815226 + var_290_13 and not isNil(var_290_12) then
				if arg_287_1.var_.characterEffect10003ui_story and not isNil(var_290_12) then
					arg_287_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_287_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 1.96599999815226) / var_290_13)
				end
			end

			if arg_287_1.time_ >= 1.96599999815226 + var_290_13 and arg_287_1.time_ < 1.96599999815226 + var_290_13 + arg_290_0 and not isNil(var_290_12) and arg_287_1.var_.characterEffect10003ui_story then
				arg_287_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_287_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			local var_290_14 = arg_287_1.actors_["10003ui_story"].transform

			if 1.96599999815226 < arg_287_1.time_ and arg_287_1.time_ <= 1.96599999815226 + arg_290_0 then
				arg_287_1.var_.moveOldPos10003ui_story = var_290_14.localPosition
			end

			local var_290_15 = 0.001

			if 1.96599999815226 <= arg_287_1.time_ and arg_287_1.time_ < 1.96599999815226 + var_290_15 then
				var_290_14.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10003ui_story, Vector3.New(0, 100, 0), (arg_287_1.time_ - 1.96599999815226) / var_290_15)
				var_290_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_14.position).x, (manager.ui.mainCamera.transform.position - var_290_14.position).y, (manager.ui.mainCamera.transform.position - var_290_14.position).z)
				var_290_14.localEulerAngles.z = 0
				var_290_14.localEulerAngles.x = 0
				var_290_14.localEulerAngles = var_290_14.localEulerAngles
			end

			if arg_287_1.time_ >= 1.96599999815226 + var_290_15 and arg_287_1.time_ < 1.96599999815226 + var_290_15 + arg_290_0 then
				var_290_14.localPosition = Vector3.New(0, 100, 0)
				var_290_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_14.position).x, (manager.ui.mainCamera.transform.position - var_290_14.position).y, (manager.ui.mainCamera.transform.position - var_290_14.position).z)
				var_290_14.localEulerAngles.z = 0
				var_290_14.localEulerAngles.x = 0
				var_290_14.localEulerAngles = var_290_14.localEulerAngles
			end

			if arg_287_1.frameCnt_ <= 1 then
				arg_287_1.dialog_:SetActive(false)
			end

			local var_290_16 = 4
			local var_290_17 = 1

			if 4 < arg_287_1.time_ and arg_287_1.time_ <= var_290_16 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0

				arg_287_1.dialog_:SetActive(true)

				arg_287_1.dialogCg_.alpha = 0

				local var_290_18 = LeanTween.value(arg_287_1.dialog_, 0, 1, 0.3)

				var_290_18:setOnUpdate(LuaHelper.FloatAction(function(arg_291_0)
					arg_287_1.dialogCg_.alpha = arg_291_0
				end))
				var_290_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_287_1.dialog_)
					var_290_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_287_1.duration_ = arg_287_1.duration_ + 0.3

				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_19 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(123541070).content)

				arg_287_1.text_.text = var_290_19

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_21 = 40 <= 0 and var_290_17 or var_290_17 * (utf8.len(var_290_19) / 40)

				if (40 <= 0 and var_290_17 or var_290_17 * (utf8.len(var_290_19) / 40)) > 0 and var_290_17 < var_290_21 then
					arg_287_1.talkMaxDuration = var_290_21
					var_290_16 = var_290_16 + 0.3

					if var_290_21 + var_290_16 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_21 + var_290_16
					end
				end

				arg_287_1.text_.text = var_290_19
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_22 = var_290_16 + 0.3
			local var_290_23 = math.max(var_290_17, arg_287_1.talkMaxDuration)

			if var_290_16 + 0.3 <= arg_287_1.time_ and arg_287_1.time_ < var_290_22 + var_290_23 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_22) / var_290_23

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_22 + var_290_23 and arg_287_1.time_ < var_290_22 + var_290_23 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play123541071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 123541071
		arg_293_1.duration_ = 7.57

		local var_293_0 = {
			zh = 4.3,
			ja = 7.566
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play123541072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1093ui_story = arg_293_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1093ui_story"].transform.position).z)
				arg_293_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1093ui_story"].transform.localEulerAngles = arg_293_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_293_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1093ui_story"].transform.position).z)
				arg_293_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1093ui_story"].transform.localEulerAngles = arg_293_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["1093ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1093ui_story == nil then
				arg_293_1.var_.characterEffect1093ui_story = var_296_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 and not isNil(var_296_1) then
				if arg_293_1.var_.characterEffect1093ui_story and not isNil(var_296_1) then
					arg_293_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1093ui_story then
				arg_293_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				if arg_293_1.var_.characterEffect1093ui_story == nil then
					arg_293_1.var_.characterEffect1093ui_story = arg_293_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_296_4 = arg_293_1.var_.characterEffect1093ui_story

				arg_293_1.var_.characterEffect1093ui_story.imageEffect:turnOff()

				var_296_4.interferenceEffect.enabled = false
				var_296_4.interferenceEffect.noise = 0.001
				var_296_4.interferenceEffect.simTimeScale = 1
				var_296_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				if arg_293_1.var_.characterEffect1093ui_story == nil then
					arg_293_1.var_.characterEffect1093ui_story = arg_293_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_293_1.var_.characterEffect1093ui_story.imageEffect:turnOff()
			end

			local var_296_6 = 0
			local var_296_7 = 0.5

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_8 = arg_293_1:GetWordFromCfg(123541071)
				local var_296_9 = arg_293_1:FormatText(var_296_8.content)

				arg_293_1.text_.text = var_296_9

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 20 <= 0 and var_296_7 or var_296_7 * (utf8.len(var_296_9) / 20)

				if (20 <= 0 and var_296_7 or var_296_7 * (utf8.len(var_296_9) / 20)) > 0 and var_296_7 < var_296_11 then
					arg_293_1.talkMaxDuration = var_296_11

					if var_296_11 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_9
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541071", "story_v_out_123541.awb") ~= 0 then
					local var_296_12 = manager.audio:GetVoiceLength("story_v_out_123541", "123541071", "story_v_out_123541.awb") / 1000

					if var_296_12 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_12 + var_296_6
					end

					if var_296_8.prefab_name ~= "" and arg_293_1.actors_[var_296_8.prefab_name] ~= nil then
						local var_296_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_8.prefab_name].transform, "story_v_out_123541", "123541071", "story_v_out_123541.awb")

						arg_293_1:RecordAudio("123541071", var_296_13)
						arg_293_1:RecordAudio("123541071", var_296_13)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_123541", "123541071", "story_v_out_123541.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_123541", "123541071", "story_v_out_123541.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_14 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_14 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_14

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_14 and arg_293_1.time_ < var_296_6 + var_296_14 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play123541072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 123541072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play123541073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1093ui_story"]) and arg_297_1.var_.characterEffect1093ui_story == nil then
				arg_297_1.var_.characterEffect1093ui_story = arg_297_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1093ui_story"]) then
				if arg_297_1.var_.characterEffect1093ui_story and not isNil(arg_297_1.actors_["1093ui_story"]) then
					arg_297_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_0)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1093ui_story"]) and arg_297_1.var_.characterEffect1093ui_story then
				arg_297_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_300_1 = 0
			local var_300_2 = 0.125

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(123541072).content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 5 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 5)

				if (5 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 5)) > 0 and var_300_2 < var_300_5 then
					arg_297_1.talkMaxDuration = var_300_5

					if var_300_5 + var_300_1 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + var_300_1
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_6 = math.max(var_300_2, arg_297_1.talkMaxDuration)

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_6 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_1) / var_300_6

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_1 + var_300_6 and arg_297_1.time_ < var_300_1 + var_300_6 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play123541073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 123541073
		arg_301_1.duration_ = 10.33

		local var_301_0 = {
			zh = 10.333,
			ja = 10.166
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play123541074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1093ui_story"]) and arg_301_1.var_.characterEffect1093ui_story == nil then
				arg_301_1.var_.characterEffect1093ui_story = arg_301_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1093ui_story"]) then
				if arg_301_1.var_.characterEffect1093ui_story and not isNil(arg_301_1.actors_["1093ui_story"]) then
					arg_301_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1093ui_story"]) and arg_301_1.var_.characterEffect1093ui_story then
				arg_301_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_304_2 = 0
			local var_304_3 = 1.05

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_4 = arg_301_1:GetWordFromCfg(123541073)
				local var_304_5 = arg_301_1:FormatText(var_304_4.content)

				arg_301_1.text_.text = var_304_5

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_7 = 42 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_5) / 42)

				if (42 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_5) / 42)) > 0 and var_304_3 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_2
					end
				end

				arg_301_1.text_.text = var_304_5
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541073", "story_v_out_123541.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_123541", "123541073", "story_v_out_123541.awb") / 1000

					if var_304_8 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_2
					end

					if var_304_4.prefab_name ~= "" and arg_301_1.actors_[var_304_4.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_4.prefab_name].transform, "story_v_out_123541", "123541073", "story_v_out_123541.awb")

						arg_301_1:RecordAudio("123541073", var_304_9)
						arg_301_1:RecordAudio("123541073", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_123541", "123541073", "story_v_out_123541.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_123541", "123541073", "story_v_out_123541.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_3, arg_301_1.talkMaxDuration)

			if var_304_2 <= arg_301_1.time_ and arg_301_1.time_ < var_304_2 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_2) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_2 + var_304_10 and arg_301_1.time_ < var_304_2 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play123541074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 123541074
		arg_305_1.duration_ = 9.97

		local var_305_0 = {
			zh = 7.033,
			ja = 9.966
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play123541075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action478")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_308_0 = 0
			local var_308_1 = 0.85

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_2 = arg_305_1:GetWordFromCfg(123541074)
				local var_308_3 = arg_305_1:FormatText(var_308_2.content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 34 <= 0 and var_308_1 or var_308_1 * (utf8.len(var_308_3) / 34)

				if (34 <= 0 and var_308_1 or var_308_1 * (utf8.len(var_308_3) / 34)) > 0 and var_308_1 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541074", "story_v_out_123541.awb") ~= 0 then
					local var_308_6 = manager.audio:GetVoiceLength("story_v_out_123541", "123541074", "story_v_out_123541.awb") / 1000

					if var_308_6 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_6 + var_308_0
					end

					if var_308_2.prefab_name ~= "" and arg_305_1.actors_[var_308_2.prefab_name] ~= nil then
						local var_308_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_2.prefab_name].transform, "story_v_out_123541", "123541074", "story_v_out_123541.awb")

						arg_305_1:RecordAudio("123541074", var_308_7)
						arg_305_1:RecordAudio("123541074", var_308_7)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_123541", "123541074", "story_v_out_123541.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_123541", "123541074", "story_v_out_123541.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_8 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_8 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_8

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_8 and arg_305_1.time_ < var_308_0 + var_308_8 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play123541075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 123541075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play123541076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1093ui_story"]) and arg_309_1.var_.characterEffect1093ui_story == nil then
				arg_309_1.var_.characterEffect1093ui_story = arg_309_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1093ui_story"]) then
				if arg_309_1.var_.characterEffect1093ui_story and not isNil(arg_309_1.actors_["1093ui_story"]) then
					arg_309_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_0)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1093ui_story"]) and arg_309_1.var_.characterEffect1093ui_story then
				arg_309_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_312_1 = 0
			local var_312_2 = 0.45

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(123541075).content)

				arg_309_1.text_.text = var_312_3

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 18 <= 0 and var_312_2 or var_312_2 * (utf8.len(var_312_3) / 18)

				if (18 <= 0 and var_312_2 or var_312_2 * (utf8.len(var_312_3) / 18)) > 0 and var_312_2 < var_312_5 then
					arg_309_1.talkMaxDuration = var_312_5

					if var_312_5 + var_312_1 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + var_312_1
					end
				end

				arg_309_1.text_.text = var_312_3
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_6 = math.max(var_312_2, arg_309_1.talkMaxDuration)

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_6 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_1) / var_312_6

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_1 + var_312_6 and arg_309_1.time_ < var_312_1 + var_312_6 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play123541076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 123541076
		arg_313_1.duration_ = 7.4

		local var_313_0 = {
			zh = 6.333,
			ja = 7.4
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play123541077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1093ui_story"]) and arg_313_1.var_.characterEffect1093ui_story == nil then
				arg_313_1.var_.characterEffect1093ui_story = arg_313_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1093ui_story"]) then
				if arg_313_1.var_.characterEffect1093ui_story and not isNil(arg_313_1.actors_["1093ui_story"]) then
					arg_313_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1093ui_story"]) and arg_313_1.var_.characterEffect1093ui_story then
				arg_313_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action484")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_316_2 = 0
			local var_316_3 = 0.7

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_4 = arg_313_1:GetWordFromCfg(123541076)
				local var_316_5 = arg_313_1:FormatText(var_316_4.content)

				arg_313_1.text_.text = var_316_5

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_7 = 28 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_5) / 28)

				if (28 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_5) / 28)) > 0 and var_316_3 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_2
					end
				end

				arg_313_1.text_.text = var_316_5
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541076", "story_v_out_123541.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_out_123541", "123541076", "story_v_out_123541.awb") / 1000

					if var_316_8 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_2
					end

					if var_316_4.prefab_name ~= "" and arg_313_1.actors_[var_316_4.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_4.prefab_name].transform, "story_v_out_123541", "123541076", "story_v_out_123541.awb")

						arg_313_1:RecordAudio("123541076", var_316_9)
						arg_313_1:RecordAudio("123541076", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_123541", "123541076", "story_v_out_123541.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_123541", "123541076", "story_v_out_123541.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_3, arg_313_1.talkMaxDuration)

			if var_316_2 <= arg_313_1.time_ and arg_313_1.time_ < var_316_2 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_2) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_2 + var_316_10 and arg_313_1.time_ < var_316_2 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play123541077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 123541077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play123541078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1093ui_story"]) and arg_317_1.var_.characterEffect1093ui_story == nil then
				arg_317_1.var_.characterEffect1093ui_story = arg_317_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1093ui_story"]) then
				if arg_317_1.var_.characterEffect1093ui_story and not isNil(arg_317_1.actors_["1093ui_story"]) then
					arg_317_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_0)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1093ui_story"]) and arg_317_1.var_.characterEffect1093ui_story then
				arg_317_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_320_1 = 0
			local var_320_2 = 1.3

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_3 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(123541077).content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 52 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 52)

				if (52 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 52)) > 0 and var_320_2 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_6 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_6 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_6

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_6 and arg_317_1.time_ < var_320_1 + var_320_6 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play123541078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 123541078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play123541079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1093ui_story = arg_321_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1093ui_story"].transform.position).z)
				arg_321_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1093ui_story"].transform.localEulerAngles = arg_321_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_321_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1093ui_story"].transform.position).z)
				arg_321_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1093ui_story"].transform.localEulerAngles = arg_321_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["1093ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1093ui_story == nil then
				arg_321_1.var_.characterEffect1093ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 and not isNil(var_324_1) then
				if arg_321_1.var_.characterEffect1093ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_2)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1093ui_story then
				arg_321_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_324_3 = 0
			local var_324_4 = 0.175

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_3 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_5 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(123541078).content)

				arg_321_1.text_.text = var_324_5

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_7 = 7 <= 0 and var_324_4 or var_324_4 * (utf8.len(var_324_5) / 7)

				if (7 <= 0 and var_324_4 or var_324_4 * (utf8.len(var_324_5) / 7)) > 0 and var_324_4 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_3 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_3
					end
				end

				arg_321_1.text_.text = var_324_5
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_8 = math.max(var_324_4, arg_321_1.talkMaxDuration)

			if var_324_3 <= arg_321_1.time_ and arg_321_1.time_ < var_324_3 + var_324_8 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_3) / var_324_8

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_3 + var_324_8 and arg_321_1.time_ < var_324_3 + var_324_8 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play123541079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 123541079
		arg_325_1.duration_ = 12.73

		local var_325_0 = {
			zh = 12.733,
			ja = 9.566
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play123541080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 1.325

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_1 = arg_325_1:GetWordFromCfg(123541079)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 53 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 53)

				if (53 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 53)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541079", "story_v_out_123541.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541079", "story_v_out_123541.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_out_123541", "123541079", "story_v_out_123541.awb")

						arg_325_1:RecordAudio("123541079", var_328_6)
						arg_325_1:RecordAudio("123541079", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_123541", "123541079", "story_v_out_123541.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_123541", "123541079", "story_v_out_123541.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play123541080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 123541080
		arg_329_1.duration_ = 9.33

		local var_329_0 = {
			zh = 5.2,
			ja = 9.333
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play123541081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0.675

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_1 = arg_329_1:GetWordFromCfg(123541080)
				local var_332_2 = arg_329_1:FormatText(var_332_1.content)

				arg_329_1.text_.text = var_332_2

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_4 = 27 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 27)

				if (27 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 27)) > 0 and var_332_0 < var_332_4 then
					arg_329_1.talkMaxDuration = var_332_4

					if var_332_4 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_4 + 0
					end
				end

				arg_329_1.text_.text = var_332_2
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541080", "story_v_out_123541.awb") ~= 0 then
					local var_332_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541080", "story_v_out_123541.awb") / 1000

					if var_332_5 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + 0
					end

					if var_332_1.prefab_name ~= "" and arg_329_1.actors_[var_332_1.prefab_name] ~= nil then
						local var_332_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_1.prefab_name].transform, "story_v_out_123541", "123541080", "story_v_out_123541.awb")

						arg_329_1:RecordAudio("123541080", var_332_6)
						arg_329_1:RecordAudio("123541080", var_332_6)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_123541", "123541080", "story_v_out_123541.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_123541", "123541080", "story_v_out_123541.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_7 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_7 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_7

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_7 and arg_329_1.time_ < 0 + var_332_7 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play123541081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 123541081
		arg_333_1.duration_ = 2.8

		local var_333_0 = {
			zh = 2,
			ja = 2.8
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play123541082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1093ui_story = arg_333_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1093ui_story"].transform.position).z)
				arg_333_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1093ui_story"].transform.localEulerAngles = arg_333_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_333_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1093ui_story"].transform.position).z)
				arg_333_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1093ui_story"].transform.localEulerAngles = arg_333_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_336_1 = arg_333_1.actors_["1093ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1093ui_story == nil then
				arg_333_1.var_.characterEffect1093ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_2 and not isNil(var_336_1) then
				if arg_333_1.var_.characterEffect1093ui_story and not isNil(var_336_1) then
					arg_333_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_2 and arg_333_1.time_ < 0 + var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1093ui_story then
				arg_333_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_336_4 = 0
			local var_336_5 = 0.175

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_6 = arg_333_1:GetWordFromCfg(123541081)
				local var_336_7 = arg_333_1:FormatText(var_336_6.content)

				arg_333_1.text_.text = var_336_7

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_9 = 7 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 7)

				if (7 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 7)) > 0 and var_336_5 < var_336_9 then
					arg_333_1.talkMaxDuration = var_336_9

					if var_336_9 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_9 + var_336_4
					end
				end

				arg_333_1.text_.text = var_336_7
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541081", "story_v_out_123541.awb") ~= 0 then
					local var_336_10 = manager.audio:GetVoiceLength("story_v_out_123541", "123541081", "story_v_out_123541.awb") / 1000

					if var_336_10 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_4
					end

					if var_336_6.prefab_name ~= "" and arg_333_1.actors_[var_336_6.prefab_name] ~= nil then
						local var_336_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_6.prefab_name].transform, "story_v_out_123541", "123541081", "story_v_out_123541.awb")

						arg_333_1:RecordAudio("123541081", var_336_11)
						arg_333_1:RecordAudio("123541081", var_336_11)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_123541", "123541081", "story_v_out_123541.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_123541", "123541081", "story_v_out_123541.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_12 = math.max(var_336_5, arg_333_1.talkMaxDuration)

			if var_336_4 <= arg_333_1.time_ and arg_333_1.time_ < var_336_4 + var_336_12 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_4) / var_336_12

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_4 + var_336_12 and arg_333_1.time_ < var_336_4 + var_336_12 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play123541082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 123541082
		arg_337_1.duration_ = 10.4

		local var_337_0 = {
			zh = 10.4,
			ja = 7.933
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play123541083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 1.025

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_1 = arg_337_1:GetWordFromCfg(123541082)
				local var_340_2 = arg_337_1:FormatText(var_340_1.content)

				arg_337_1.text_.text = var_340_2

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 41 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 41)

				if (41 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 41)) > 0 and var_340_0 < var_340_4 then
					arg_337_1.talkMaxDuration = var_340_4

					if var_340_4 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_4 + 0
					end
				end

				arg_337_1.text_.text = var_340_2
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541082", "story_v_out_123541.awb") ~= 0 then
					local var_340_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541082", "story_v_out_123541.awb") / 1000

					if var_340_5 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + 0
					end

					if var_340_1.prefab_name ~= "" and arg_337_1.actors_[var_340_1.prefab_name] ~= nil then
						local var_340_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_1.prefab_name].transform, "story_v_out_123541", "123541082", "story_v_out_123541.awb")

						arg_337_1:RecordAudio("123541082", var_340_6)
						arg_337_1:RecordAudio("123541082", var_340_6)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_123541", "123541082", "story_v_out_123541.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_123541", "123541082", "story_v_out_123541.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play123541083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 123541083
		arg_341_1.duration_ = 9

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play123541084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if arg_341_1.bgs_.BA0204a == nil then
				local var_344_0 = Object.Instantiate(arg_341_1.paintGo_)

				var_344_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "BA0204a")
				var_344_0.name = "BA0204a"
				var_344_0.transform.parent = arg_341_1.stage_.transform
				var_344_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_341_1.bgs_.BA0204a = var_344_0
			end

			if 2 < arg_341_1.time_ and arg_341_1.time_ <= 2 + arg_344_0 then
				local var_344_1 = arg_341_1.bgs_.BA0204a

				arg_341_1.bgs_.BA0204a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_344_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_344_2 = var_344_1:GetComponent("SpriteRenderer")

				if var_344_2 and var_344_2.sprite then
					local var_344_3 = 2 * (var_344_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_344_1.transform.localScale = Vector3.New(var_344_3 / var_344_2.sprite.bounds.size.y < var_344_3 * manager.ui.mainCameraCom_.aspect / var_344_2.sprite.bounds.size.x and var_344_3 * manager.ui.mainCameraCom_.aspect / var_344_2.sprite.bounds.size.x or var_344_3 / var_344_2.sprite.bounds.size.y, var_344_3 / var_344_2.sprite.bounds.size.y < var_344_3 * manager.ui.mainCameraCom_.aspect / var_344_2.sprite.bounds.size.x and var_344_3 * manager.ui.mainCameraCom_.aspect / var_344_2.sprite.bounds.size.x or var_344_3 / var_344_2.sprite.bounds.size.y, 0)
				end

				for iter_344_0, iter_344_1 in pairs(arg_341_1.bgs_) do
					if iter_344_0 ~= "BA0204a" then
						iter_344_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_344_4 = 0

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.mask_.enabled = true
				arg_341_1.mask_.raycastTarget = true

				arg_341_1:SetGaussion(false)
			end

			local var_344_5 = 2

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_5 then
				local var_344_6 = Color.New(0, 0, 0)

				var_344_6.a = Mathf.Lerp(0, 1, (arg_341_1.time_ - var_344_4) / var_344_5)
				arg_341_1.mask_.color = var_344_6
			end

			if arg_341_1.time_ >= var_344_4 + var_344_5 and arg_341_1.time_ < var_344_4 + var_344_5 + arg_344_0 then
				local var_344_7 = Color.New(0, 0, 0)

				var_344_7.a = 1
				arg_341_1.mask_.color = var_344_7
			end

			local var_344_8 = 2

			if 2 < arg_341_1.time_ and arg_341_1.time_ <= var_344_8 + arg_344_0 then
				arg_341_1.mask_.enabled = true
				arg_341_1.mask_.raycastTarget = true

				arg_341_1:SetGaussion(false)
			end

			local var_344_9 = 2

			if var_344_8 <= arg_341_1.time_ and arg_341_1.time_ < var_344_8 + var_344_9 then
				local var_344_10 = Color.New(0, 0, 0)

				var_344_10.a = Mathf.Lerp(1, 0, (arg_341_1.time_ - var_344_8) / var_344_9)
				arg_341_1.mask_.color = var_344_10
			end

			if arg_341_1.time_ >= var_344_8 + var_344_9 and arg_341_1.time_ < var_344_8 + var_344_9 + arg_344_0 then
				local var_344_11 = Color.New(0, 0, 0)

				arg_341_1.mask_.enabled = false
				var_344_11.a = 0
				arg_341_1.mask_.color = var_344_11
			end

			local var_344_12 = arg_341_1.actors_["1093ui_story"]

			if 1.96599999815226 < arg_341_1.time_ and arg_341_1.time_ <= 1.96599999815226 + arg_344_0 and not isNil(var_344_12) and arg_341_1.var_.characterEffect1093ui_story == nil then
				arg_341_1.var_.characterEffect1093ui_story = var_344_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_13 = 0.034000001847744

			if 1.96599999815226 <= arg_341_1.time_ and arg_341_1.time_ < 1.96599999815226 + var_344_13 and not isNil(var_344_12) then
				if arg_341_1.var_.characterEffect1093ui_story and not isNil(var_344_12) then
					arg_341_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 1.96599999815226) / var_344_13)
				end
			end

			if arg_341_1.time_ >= 1.96599999815226 + var_344_13 and arg_341_1.time_ < 1.96599999815226 + var_344_13 + arg_344_0 and not isNil(var_344_12) and arg_341_1.var_.characterEffect1093ui_story then
				arg_341_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_344_14 = arg_341_1.actors_["1093ui_story"].transform

			if 1.96599999815226 < arg_341_1.time_ and arg_341_1.time_ <= 1.96599999815226 + arg_344_0 then
				arg_341_1.var_.moveOldPos1093ui_story = var_344_14.localPosition
			end

			local var_344_15 = 0.001

			if 1.96599999815226 <= arg_341_1.time_ and arg_341_1.time_ < 1.96599999815226 + var_344_15 then
				var_344_14.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_341_1.time_ - 1.96599999815226) / var_344_15)
				var_344_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_14.position).x, (manager.ui.mainCamera.transform.position - var_344_14.position).y, (manager.ui.mainCamera.transform.position - var_344_14.position).z)
				var_344_14.localEulerAngles.z = 0
				var_344_14.localEulerAngles.x = 0
				var_344_14.localEulerAngles = var_344_14.localEulerAngles
			end

			if arg_341_1.time_ >= 1.96599999815226 + var_344_15 and arg_341_1.time_ < 1.96599999815226 + var_344_15 + arg_344_0 then
				var_344_14.localPosition = Vector3.New(0, 100, 0)
				var_344_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_14.position).x, (manager.ui.mainCamera.transform.position - var_344_14.position).y, (manager.ui.mainCamera.transform.position - var_344_14.position).z)
				var_344_14.localEulerAngles.z = 0
				var_344_14.localEulerAngles.x = 0
				var_344_14.localEulerAngles = var_344_14.localEulerAngles
			end

			local var_344_16 = arg_341_1.bgs_.BA0204a.transform

			if 2 < arg_341_1.time_ and arg_341_1.time_ <= 2 + arg_344_0 then
				arg_341_1.var_.moveOldPosBA0204a = var_344_16.localPosition
			end

			local var_344_17 = 0.001

			if 2 <= arg_341_1.time_ and arg_341_1.time_ < 2 + var_344_17 then
				var_344_16.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPosBA0204a, Vector3.New(0, 1, 9.5), (arg_341_1.time_ - 2) / var_344_17)
			end

			if arg_341_1.time_ >= 2 + var_344_17 and arg_341_1.time_ < 2 + var_344_17 + arg_344_0 then
				var_344_16.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_344_18 = arg_341_1.bgs_.BA0204a.transform

			if 2.01666666666667 < arg_341_1.time_ and arg_341_1.time_ <= 2.01666666666667 + arg_344_0 then
				arg_341_1.var_.moveOldPosBA0204a = var_344_18.localPosition
			end

			local var_344_19 = 3.5

			if 2.01666666666667 <= arg_341_1.time_ and arg_341_1.time_ < 2.01666666666667 + var_344_19 then
				var_344_18.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPosBA0204a, Vector3.New(0, 1, 10), (arg_341_1.time_ - 2.01666666666667) / var_344_19)
			end

			if arg_341_1.time_ >= 2.01666666666667 + var_344_19 and arg_341_1.time_ < 2.01666666666667 + var_344_19 + arg_344_0 then
				var_344_18.localPosition = Vector3.New(0, 1, 10)
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_344_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_341_1.bgmTxt_.text ~= var_344_22 and arg_341_1.bgmTxt_.text ~= "" then
						if arg_341_1.bgmTxt2_.text ~= "" then
							arg_341_1.bgmTxt_.text = arg_341_1.bgmTxt2_.text
						end

						arg_341_1.bgmTxt2_.text = var_344_22

						arg_341_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_341_1.bgmTxt_.text = var_344_22
						arg_341_1.bgmTxt2_.text = var_344_22
					end

					if arg_341_1.bgmTimer then
						arg_341_1.bgmTimer:Stop()

						arg_341_1.bgmTimer = nil
					end

					if arg_341_1.settingData.show_music_name == 1 then
						arg_341_1.musicController:SetSelectedState("show")
						arg_341_1.musicAnimator_:Play("open", 0, 0)

						if arg_341_1.settingData.music_time ~= 0 then
							arg_341_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_341_1.settingData.music_time), function()
								if arg_341_1 == nil or isNil(arg_341_1.bgmTxt_) then
									return
								end

								arg_341_1.musicController:SetSelectedState("hide")
								arg_341_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.566666666666667 < arg_341_1.time_ and arg_341_1.time_ <= 0.566666666666667 + arg_344_0 then
				arg_341_1:AudioAction("play", "music", "bgm_activity_2_4_story_firework", "bgm_activity_2_4_story_firework", "bgm_activity_2_4_story_firework.awb")

				local var_344_25 = manager.audio:GetAudioName("bgm_activity_2_4_story_firework", "bgm_activity_2_4_story_firework")

				if "" ~= "" then
					if arg_341_1.bgmTxt_.text ~= var_344_25 and arg_341_1.bgmTxt_.text ~= "" then
						if arg_341_1.bgmTxt2_.text ~= "" then
							arg_341_1.bgmTxt_.text = arg_341_1.bgmTxt2_.text
						end

						arg_341_1.bgmTxt2_.text = var_344_25

						arg_341_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_341_1.bgmTxt_.text = var_344_25
						arg_341_1.bgmTxt2_.text = var_344_25
					end

					if arg_341_1.bgmTimer then
						arg_341_1.bgmTimer:Stop()

						arg_341_1.bgmTimer = nil
					end

					if arg_341_1.settingData.show_music_name == 1 then
						arg_341_1.musicController:SetSelectedState("show")
						arg_341_1.musicAnimator_:Play("open", 0, 0)

						if arg_341_1.settingData.music_time ~= 0 then
							arg_341_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_341_1.settingData.music_time), function()
								if arg_341_1 == nil or isNil(arg_341_1.bgmTxt_) then
									return
								end

								arg_341_1.musicController:SetSelectedState("hide")
								arg_341_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.76666666666667 < arg_341_1.time_ and arg_341_1.time_ <= 1.76666666666667 + arg_344_0 then
				arg_341_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks", "")
			end

			if 1.76666666666667 < arg_341_1.time_ and arg_341_1.time_ <= 1.76666666666667 + arg_344_0 then
				arg_341_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks_loop", "")
			end

			if arg_341_1.frameCnt_ <= 1 then
				arg_341_1.dialog_:SetActive(false)
			end

			local var_344_28 = 4
			local var_344_29 = 1.475

			if 4 < arg_341_1.time_ and arg_341_1.time_ <= var_344_28 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0

				arg_341_1.dialog_:SetActive(true)

				arg_341_1.dialogCg_.alpha = 0

				local var_344_30 = LeanTween.value(arg_341_1.dialog_, 0, 1, 0.3)

				var_344_30:setOnUpdate(LuaHelper.FloatAction(function(arg_347_0)
					arg_341_1.dialogCg_.alpha = arg_347_0
				end))
				var_344_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_341_1.dialog_)
					var_344_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_341_1.duration_ = arg_341_1.duration_ + 0.3

				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_31 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(123541083).content)

				arg_341_1.text_.text = var_344_31

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_33 = 59 <= 0 and var_344_29 or var_344_29 * (utf8.len(var_344_31) / 59)

				if (59 <= 0 and var_344_29 or var_344_29 * (utf8.len(var_344_31) / 59)) > 0 and var_344_29 < var_344_33 then
					arg_341_1.talkMaxDuration = var_344_33
					var_344_28 = var_344_28 + 0.3

					if var_344_33 + var_344_28 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_33 + var_344_28
					end
				end

				arg_341_1.text_.text = var_344_31
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_34 = var_344_28 + 0.3
			local var_344_35 = math.max(var_344_29, arg_341_1.talkMaxDuration)

			if var_344_28 + 0.3 <= arg_341_1.time_ and arg_341_1.time_ < var_344_34 + var_344_35 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_34) / var_344_35

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_34 + var_344_35 and arg_341_1.time_ < var_344_34 + var_344_35 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "BA0204a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "BA0204a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play123541084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 123541084
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play123541085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.725

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_1 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(123541084).content)

				arg_349_1.text_.text = var_352_1

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_3 = 29 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 29)

				if (29 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 29)) > 0 and var_352_0 < var_352_3 then
					arg_349_1.talkMaxDuration = var_352_3

					if var_352_3 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_3 + 0
					end
				end

				arg_349_1.text_.text = var_352_1
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_4 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_4

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play123541085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 123541085
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play123541086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0.5

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_1 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(123541085).content)

				arg_353_1.text_.text = var_356_1

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_3 = 20 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 20)

				if (20 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 20)) > 0 and var_356_0 < var_356_3 then
					arg_353_1.talkMaxDuration = var_356_3

					if var_356_3 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_3 + 0
					end
				end

				arg_353_1.text_.text = var_356_1
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_4 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_4

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play123541086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 123541086
		arg_357_1.duration_ = 2.8

		local var_357_0 = {
			zh = 2.8,
			ja = 2.4
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play123541087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0.35

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_1 = arg_357_1:GetWordFromCfg(123541086)
				local var_360_2 = arg_357_1:FormatText(var_360_1.content)

				arg_357_1.text_.text = var_360_2

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_4 = 14 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 14)

				if (14 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 14)) > 0 and var_360_0 < var_360_4 then
					arg_357_1.talkMaxDuration = var_360_4

					if var_360_4 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_4 + 0
					end
				end

				arg_357_1.text_.text = var_360_2
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541086", "story_v_out_123541.awb") ~= 0 then
					local var_360_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541086", "story_v_out_123541.awb") / 1000

					if var_360_5 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + 0
					end

					if var_360_1.prefab_name ~= "" and arg_357_1.actors_[var_360_1.prefab_name] ~= nil then
						local var_360_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_1.prefab_name].transform, "story_v_out_123541", "123541086", "story_v_out_123541.awb")

						arg_357_1:RecordAudio("123541086", var_360_6)
						arg_357_1:RecordAudio("123541086", var_360_6)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_123541", "123541086", "story_v_out_123541.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_123541", "123541086", "story_v_out_123541.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_7 and arg_357_1.time_ < 0 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play123541087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 123541087
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play123541088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.425

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_1 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(123541087).content)

				arg_361_1.text_.text = var_364_1

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_3 = 17 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 17)

				if (17 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 17)) > 0 and var_364_0 < var_364_3 then
					arg_361_1.talkMaxDuration = var_364_3

					if var_364_3 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_3 + 0
					end
				end

				arg_361_1.text_.text = var_364_1
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_4 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_4

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play123541088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 123541088
		arg_365_1.duration_ = 14.5

		local var_365_0 = {
			zh = 14.5,
			ja = 12.666
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play123541089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 1.325

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:GetWordFromCfg(123541088)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.text_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 53 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 53)

				if (53 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 53)) > 0 and var_368_0 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end

				arg_365_1.text_.text = var_368_2
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541088", "story_v_out_123541.awb") ~= 0 then
					local var_368_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541088", "story_v_out_123541.awb") / 1000

					if var_368_5 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + 0
					end

					if var_368_1.prefab_name ~= "" and arg_365_1.actors_[var_368_1.prefab_name] ~= nil then
						local var_368_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_1.prefab_name].transform, "story_v_out_123541", "123541088", "story_v_out_123541.awb")

						arg_365_1:RecordAudio("123541088", var_368_6)
						arg_365_1:RecordAudio("123541088", var_368_6)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_123541", "123541088", "story_v_out_123541.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_123541", "123541088", "story_v_out_123541.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play123541089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 123541089
		arg_369_1.duration_ = 8.83

		local var_369_0 = {
			zh = 7.733,
			ja = 8.833
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play123541090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0.65

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_1 = arg_369_1:GetWordFromCfg(123541089)
				local var_372_2 = arg_369_1:FormatText(var_372_1.content)

				arg_369_1.text_.text = var_372_2

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_4 = 26 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_2) / 26)

				if (26 <= 0 and var_372_0 or var_372_0 * (utf8.len(var_372_2) / 26)) > 0 and var_372_0 < var_372_4 then
					arg_369_1.talkMaxDuration = var_372_4

					if var_372_4 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_4 + 0
					end
				end

				arg_369_1.text_.text = var_372_2
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541089", "story_v_out_123541.awb") ~= 0 then
					local var_372_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541089", "story_v_out_123541.awb") / 1000

					if var_372_5 + 0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + 0
					end

					if var_372_1.prefab_name ~= "" and arg_369_1.actors_[var_372_1.prefab_name] ~= nil then
						local var_372_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_1.prefab_name].transform, "story_v_out_123541", "123541089", "story_v_out_123541.awb")

						arg_369_1:RecordAudio("123541089", var_372_6)
						arg_369_1:RecordAudio("123541089", var_372_6)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_123541", "123541089", "story_v_out_123541.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_123541", "123541089", "story_v_out_123541.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_7 = math.max(var_372_0, arg_369_1.talkMaxDuration)

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_7 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - 0) / var_372_7

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= 0 + var_372_7 and arg_369_1.time_ < 0 + var_372_7 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play123541090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 123541090
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play123541091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0.25

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_1 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(123541090).content)

				arg_373_1.text_.text = var_376_1

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_3 = 10 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 10)

				if (10 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_1) / 10)) > 0 and var_376_0 < var_376_3 then
					arg_373_1.talkMaxDuration = var_376_3

					if var_376_3 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_3 + 0
					end
				end

				arg_373_1.text_.text = var_376_1
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_4 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_4 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_4

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_4 and arg_373_1.time_ < 0 + var_376_4 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play123541091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 123541091
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play123541092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 1

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_1 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(123541091).content)

				arg_377_1.text_.text = var_380_1

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_3 = 40 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 40)

				if (40 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 40)) > 0 and var_380_0 < var_380_3 then
					arg_377_1.talkMaxDuration = var_380_3

					if var_380_3 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_3 + 0
					end
				end

				arg_377_1.text_.text = var_380_1
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_4 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_4

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play123541092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 123541092
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play123541093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 1.075

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_1 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(123541092).content)

				arg_381_1.text_.text = var_384_1

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_3 = 43 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 43)

				if (43 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 43)) > 0 and var_384_0 < var_384_3 then
					arg_381_1.talkMaxDuration = var_384_3

					if var_384_3 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_3 + 0
					end
				end

				arg_381_1.text_.text = var_384_1
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_4 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_4 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_4

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_4 and arg_381_1.time_ < 0 + var_384_4 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play123541093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 123541093
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play123541094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.6

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(123541093).content)

				arg_385_1.text_.text = var_388_1

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_3 = 24 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_1) / 24)

				if (24 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_1) / 24)) > 0 and var_388_0 < var_388_3 then
					arg_385_1.talkMaxDuration = var_388_3

					if var_388_3 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_3 + 0
					end
				end

				arg_385_1.text_.text = var_388_1
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_4 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_4 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_4

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_4 and arg_385_1.time_ < 0 + var_388_4 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play123541094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 123541094
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play123541095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0.8

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_1 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(123541094).content)

				arg_389_1.text_.text = var_392_1

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_3 = 32 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 32)

				if (32 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 32)) > 0 and var_392_0 < var_392_3 then
					arg_389_1.talkMaxDuration = var_392_3

					if var_392_3 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_3 + 0
					end
				end

				arg_389_1.text_.text = var_392_1
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_4 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_4 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_4

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_4 and arg_389_1.time_ < 0 + var_392_4 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play123541095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 123541095
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play123541096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 1.05

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(123541095).content)

				arg_393_1.text_.text = var_396_1

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_3 = 42 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 42)

				if (42 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 42)) > 0 and var_396_0 < var_396_3 then
					arg_393_1.talkMaxDuration = var_396_3

					if var_396_3 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_3 + 0
					end
				end

				arg_393_1.text_.text = var_396_1
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_4 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_4 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_4

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_4 and arg_393_1.time_ < 0 + var_396_4 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play123541096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 123541096
		arg_397_1.duration_ = 9.77

		local var_397_0 = {
			zh = 9.766,
			ja = 4.866
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play123541097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.65

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_1 = arg_397_1:GetWordFromCfg(123541096)
				local var_400_2 = arg_397_1:FormatText(var_400_1.content)

				arg_397_1.text_.text = var_400_2

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 26 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 26)

				if (26 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 26)) > 0 and var_400_0 < var_400_4 then
					arg_397_1.talkMaxDuration = var_400_4

					if var_400_4 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_4 + 0
					end
				end

				arg_397_1.text_.text = var_400_2
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541096", "story_v_out_123541.awb") ~= 0 then
					local var_400_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541096", "story_v_out_123541.awb") / 1000

					if var_400_5 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + 0
					end

					if var_400_1.prefab_name ~= "" and arg_397_1.actors_[var_400_1.prefab_name] ~= nil then
						local var_400_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_1.prefab_name].transform, "story_v_out_123541", "123541096", "story_v_out_123541.awb")

						arg_397_1:RecordAudio("123541096", var_400_6)
						arg_397_1:RecordAudio("123541096", var_400_6)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_123541", "123541096", "story_v_out_123541.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_123541", "123541096", "story_v_out_123541.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_7 and arg_397_1.time_ < 0 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play123541097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 123541097
		arg_401_1.duration_ = 4.53

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play123541098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.375

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:GetWordFromCfg(123541097)
				local var_404_2 = arg_401_1:FormatText(var_404_1.content)

				arg_401_1.text_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 13 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 13)

				if (13 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 13)) > 0 and var_404_0 < var_404_4 then
					arg_401_1.talkMaxDuration = var_404_4

					if var_404_4 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_4 + 0
					end
				end

				arg_401_1.text_.text = var_404_2
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123541", "123541097", "story_v_out_123541.awb") ~= 0 then
					local var_404_5 = manager.audio:GetVoiceLength("story_v_out_123541", "123541097", "story_v_out_123541.awb") / 1000

					if var_404_5 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + 0
					end

					if var_404_1.prefab_name ~= "" and arg_401_1.actors_[var_404_1.prefab_name] ~= nil then
						local var_404_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_1.prefab_name].transform, "story_v_out_123541", "123541097", "story_v_out_123541.awb")

						arg_401_1:RecordAudio("123541097", var_404_6)
						arg_401_1:RecordAudio("123541097", var_404_6)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_123541", "123541097", "story_v_out_123541.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_123541", "123541097", "story_v_out_123541.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_7 and arg_401_1.time_ < 0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play123541098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 123541098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
			arg_405_1.auto_ = false
		end

		function arg_405_1.playNext_(arg_407_0)
			arg_405_1.onStoryFinished_()
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 1.35

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(123541098).content)

				arg_405_1.text_.text = var_408_1

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_3 = 54 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 54)

				if (54 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 54)) > 0 and var_408_0 < var_408_3 then
					arg_405_1.talkMaxDuration = var_408_3

					if var_408_3 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_3 + 0
					end
				end

				arg_405_1.text_.text = var_408_1
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_4 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_4

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K04f",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST06",
		"TextureConfig/Background/K07g",
		"TextureConfig/Background/BA0204a"
	},
	voices = {
		"story_v_out_123541.awb"
	}
}
